{
  description = "Welteki's Nix library";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    vscode-server = {
      url = "github:msteen/nixos-vscode-server";
      flake = false;
    };
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    devenv.url = "github:cachix/devenv/v0.6.3";
    inlets.url = "github:welteki/inlets-nix";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, utils, ... }@inputs: {
    overlays = {
      default = import ./overlay/default.nix inputs;
      home = import ./overlay/home.nix inputs;
    };

    nixosModules = rec {
      vscode-server = import inputs.vscode-server;
      auto-fix-vscode-server = vscode-server;
      common = import ./modules/common.nix;
      welteki-users = import ./modules/welteki-users.nix;
      hetzner-cloud = import ./modules/virtualization/hetzner-cloud.nix;
      home = import ./modules/home.nix;
    };
  } // utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlays.default ];
      };

      pkgs-home = import nixpkgs-unstable {
        inherit system;
        overlays = [ self.overlays.home ];
      };
    in
    {
      legacyPackages.homeConfigurations = {
        welteki = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs-home;
          modules = [
            self.nixosModules.home
            ({ config, pkgs, lib, ... }: {
              # Let Home Manager install and manage itself.
              programs.home-manager.enable = true;

              fonts.fontconfig.enable = true;

              home = {
                username = "welteki";
                homeDirectory = if pkgs.stdenv.isDarwin then "/Users/welteki" else "/home/welteki";
                stateVersion = "22.05";

                packages = [
                  pkgs.nerd-fonts.fira-code
                ] ++ lib.optionals pkgs.stdenv.isDarwin [
                  # Ensure at least bash v5 on macOS
                  pkgs.bash
                ];
              };
            })
          ];
        };

        welteki-mb-air = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs-home;
          modules = [
            self.nixosModules.home
            ({ pkgs, ... }: {
              # Let Home Manager install and manage itself.
              programs.home-manager.enable = true;

              fonts.fontconfig.enable = true;

              home = {
                username = "welteki";
                homeDirectory = "/Users/welteki";
                stateVersion = "22.05";

                packages = [
                  pkgs.nerd-fonts.fira-code
                ];
              };

              programs = {
                kitty = {
                  enable = true;
                  font = {
                    name = "FiraCode Nerd Font Mono";
                    size = 11.0;
                  };
                };
              };

            })
          ];
        };
      };

      packages = {
        inherit (pkgs)
          inlets
          actuated-cli
          caddy
          devenv
          mass-deploy
          kubetrim;
      };

      devShells.default = inputs.devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          ({ pkgs, ... }: {
            languages.nix.enable = true;
            languages.go.enable = true;
          })
        ];
      };
    });
}
