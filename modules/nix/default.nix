{ config, lib, ... }:
{
  options.welteki.nix = {
    enableFlakes = lib.mkOption {
      default = false;
      example = true;
    };
  };

  config = {
    nix = {
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-then 30d";
      };

      extraOptions = lib.mkIf config.welteki.nix.enableFlakes ''
        experimental-features = nix-command flakes
      '';

      settings = {
        require-sigs = true;
        auto-optimise-store = true;

        substituters = [
          "https://welteki.cachix.org"
        ];
        trusted-public-keys = [
          "welteki.cachix.org-1:zb0txiNEbjq9Fx7svp4LhTgFIQHKSa5ESi7QlLFjjQY="
        ];

        # Allow users with sudo to modify the nix store
        trusted-users = [
          "root"
          "@wheel"
        ];
      };
    };
  };
}
