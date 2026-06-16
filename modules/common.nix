{ lib, pkgs, ... }:

{
  imports = [
    ./nix
  ];

  networking.firewall = {
    allowPing = false;
    logRefusedConnections = false;
  };

  boot.tmp.cleanOnBoot = true;

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    # ports = [ 14436 ];
  };

  environment.systemPackages = lib.attrVals [ "vim" ] pkgs;
}
