{ config, pkgs, ... }:

let
  ssh-keys = import ./ssh-keys.nix;
in
{
  users.users.welteki = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = ssh-keys.welteki;
    extraGroups = [ "wheel" ];
  };
}
