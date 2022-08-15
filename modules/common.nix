{ lib, pkgs, ... }:

{
  imports = [
    ./nix
  ];

  networking.firewall = {
    allowPing = false;
    logRefusedConnections = false;
  };

  boot.cleanTmpDir = true;

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    # ports = [ 14436 ];
  };

  environment.systemPackages = lib.attrVals [ "vim" "git" ] pkgs;
}
