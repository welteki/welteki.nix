{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ../../modules/common.nix
    ../../modules/welteki-users.nix

    inputs.faasd.nixosModules.faasd
  ];

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    loader = {
      grub.enable = lib.mkDefault false;
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

  services.faasd.enable = true;

  networking.hostName = "nixpi";
  system.stateVersion = "22.05";
}
