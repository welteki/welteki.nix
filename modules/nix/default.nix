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
      autoOptimiseStore = true;

      requireSignedBinaryCaches = true;
      binaryCaches = [
        "https://welteki.cachix.org"
      ];
      binaryCachePublicKeys = [
        "welteki.cachix.org-1:zb0txiNEbjq9Fx7svp4LhTgFIQHKSa5ESi7QlLFjjQY="
      ];

      extraOptions = lib.mkIf config.welteki.nix.enableFlakes ''
        experimental-features = nix-command flakes
      '';

      # Allow users with sudo to modify the nix store
      trustedUsers = [
        "root"
        "@wheel"
      ];
    };
  };
}
