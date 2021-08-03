{
  description = "Welteki's Nix library";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";
    utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
  };

  outputs = { self, nixpkgs, utils, ... }@inputs: {

    nixosModules = {
      common = import ./modules/common.nix;
      welteki-users = import ./modules/welteki-users.nix;
    };

  } // utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = [ pkgs.nixpkgs-fmt ];
      };
    });
}
