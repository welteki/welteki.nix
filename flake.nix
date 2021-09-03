{
  description = "Welteki's Nix library";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";
    utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
  };

  outputs = { self, nixpkgs, utils, ... }@inputs: {
    overlay = import ./overlay/default.nix inputs;

    nixosModules = {
      auto-fix-vscode-server = import ./modules/auto-fix-vscode-server.nix;
      common = import ./modules/common.nix;
      welteki-users = import ./modules/welteki-users.nix;
    };

  } // utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlay ];
      };
    in
    {
      packages = {
        caddy = pkgs.caddy;
      };

      devShell = pkgs.mkShell {
        buildInputs = [ pkgs.nixpkgs-fmt ];
      };
    });
}
