{ config, ... }:

let
  ssh-keys = import ./ssh-keys.nix;
in
{
  users.users.welteki = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = ssh-keys.welteki;
    extraGroups = [ "wheel" ];
  };

  # Allow users with sudo to modify the nix store
  nix.trustedUsers = [ "root" "@wheel" ];
}
