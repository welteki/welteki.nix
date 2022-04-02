{
  description = "Welteki's Nix library";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    deploy-rs.url = "github:serokell/deploy-rs";

    nixery.url = "github:tazjin/nixery";
    nixery.flake = false;

    vscode-server.url = "github:msteen/nixos-vscode-server";
    vscode-server.flake = false;
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, utils, deploy-rs, ... }@inputs: {
    overlay = import ./overlay/default.nix inputs;

    overlays.home = import ./overlay/home.nix;

    nixosModules = {
      auto-fix-vscode-server = import ./modules/auto-fix-vscode-server.nix inputs;
      common = import ./modules/common.nix;
      welteki-users = import ./modules/welteki-users.nix;
      hetzner-cloud = import ./modules/virtualization/hetzner-cloud.nix;
      home = import ./modules/home.nix;
    };

    deploy = {
      magicRollback = true;
      autoRollback = true;

      sshUser = "welteki";
      sshOpts = [ "-i" "~/.ssh/welteki" ];

      nodes.shlorp =
        let
          system = "x86_64-linux";
        in
        {
          hostname = "shlorp.welteki.com";
          profiles.welteki-home = {
            user = "welteki";
            profilePath = "/nix/var/nix/profiles/per-user/welteki/home-manager";
            path =
              deploy-rs.lib.${system}.activate.home-manager self.legacyPackages.${system}.homeConfigurations.welteki;
          };
        };
    };

  } // utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlay ];
      };

      pkgs-home = import nixpkgs-unstable {
        inherit system;
        overlays = [ self.overlays.home ];
      };
    in
    {
      legacyPackages.homeConfigurations.welteki =
        let
          configuration = { config, pkgs, lib, ... }: {
            imports = [ self.nixosModules.home ];

            # Let Home Manager install and manage itself.
            programs.home-manager.enable = true;

            home.packages = [ ] ++ lib.optionals pkgs.stdenv.isDarwin [
              # Ensure at least bash v4 on macOS
              pkgs.bash
            ];
          };

        in
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit system;
          pkgs = pkgs-home;
          homeDirectory = if pkgs.stdenv.isDarwin then "/Users/welteki" else "/home/welteki";
          username = "welteki";
          stateVersion = "21.11";
          inherit configuration;
        };

      packages = {
        inherit (pkgs) caddy nixery;
        inherit (pkgs-home) lazygit gh-login;
      };

      devShell = pkgs.mkShell {
        buildInputs = [
          deploy-rs.packages.${system}.deploy-rs
          pkgs.nixpkgs-fmt
        ];
      };

      checks = deploy-rs.lib.${system}.deployChecks self.deploy;
    });
}
