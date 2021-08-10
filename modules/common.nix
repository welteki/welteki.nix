{ lib, pkgs, ... }:

{
  networking.firewall = {
    allowPing = false;
    logRefusedConnections = false;
  };

  boot.cleanTmpDir = true;

  nix.autoOptimiseStore = true;

  nix.requireSignedBinaryCaches = true;
  nix.binaryCaches = [ "https://welteki.cachix.org" ];
  nix.binaryCachePublicKeys = [ "welteki.cachix.org-1:zb0txiNEbjq9Fx7svp4LhTgFIQHKSa5ESi7QlLFjjQY=" ];

  nix.extraOptions = ''
    # experimental-features = nix-command flakes
  '';

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    # ports = [ 14436 ];
  };

  environment.systemPackages = lib.attrVals [ "vim" ] pkgs;
}
