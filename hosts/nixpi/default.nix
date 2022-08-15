{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/common.nix
    ../../modules/welteki-users.nix
  ];

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    loader = {
      grub.enable = lib.mkDefault false;

      raspberryPi = {
        enable = true;
        version = 3;

      };
    };

  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  swapDevices = [{ device = "/swapfile"; size = 1024; }];

  documentation.nixos.enable = false;

  welteki.nix.enableFlakes = true;

  networking.hostName = "nixpi";
  system.stateVersion = "22.05";
}
