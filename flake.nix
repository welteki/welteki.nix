{
  description = "Welteki's Nix library";

  inputs = {
    vscode-server = {
      url = "github:msteen/nixos-vscode-server";
      flake = false;
    };
    nixpkgs.url = "nixpkgs/nixos-25.05";
    utils.url = "github:numtide/flake-utils";
    devenv.url = "github:cachix/devenv/v1.8";
    inlets.url = "github:welteki/inlets-nix";
  };

  nixConfig = {
    extra-trusted-public-keys =
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, utils, ... }@inputs:
    {
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
      in {
        packages = {
          inherit (pkgs)
            inlets actuated-cli caddy devenv mass-deploy kubetrim
            nats-server-dev;
        };

        devShells.default = inputs.devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [
            ({ pkgs, ... }: {
              languages.nix.enable = true;
              languages.nix.lsp.package = pkgs.nixd;
              languages.go.enable = true;
            })
          ];
        };
      });
}
