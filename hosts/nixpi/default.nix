{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ../../modules/common.nix
    ../../modules/welteki-users.nix

    inputs.faasd.nixosModules.faasd
  ];

  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.kernelParams = [ "cma=32M" ];
  boot.initrd.kernelModules = [ "vc4" "bcm2835_dma" "i2c_bcm2835" ];
  hardware.enableRedistributableFirmware = true;

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

  services.faasd.enable = true;

  networking.hostName = "nixpi";
  system.stateVersion = "22.05";
}
