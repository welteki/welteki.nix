{ config, lib, pkgs, ... }:

let
  cfg = config.welteki;
in
{
  options.welteki.docker.enable = lib.mkOption {
    default = false;
  };

  config = lib.mkIf cfg.docker.enable {
    virtualisation.docker.enable = true;

    environment.systemPackages = [ pkgs.docker-compose ];
  };
}
