{
  description = "Welteki's Nix library";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv/v2.1.2";
    inlets.url = "github:welteki/inlets-nix";
  };

  nixConfig = {
    extra-trusted-public-keys =
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      flake = {
        overlays.default = import ./overlay/default.nix inputs;

        nixosModules = {
          common = import ./modules/common.nix;
          welteki-users = import ./modules/welteki-users.nix;
        };
      };

      perSystem = { system, ... }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ inputs.inlets.overlays.default inputs.self.overlays.default ];
            config.allowUnfree = true;
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
        };
    };
}
