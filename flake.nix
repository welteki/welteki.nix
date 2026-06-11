{
  description = "Welteki's Nix library";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
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
      };

      nixosModules = {
        common = import ./modules/common.nix;
        welteki-users = import ./modules/welteki-users.nix;
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
            inlets actuated-cli caddy devenv mass-deploy kubetrim;
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
