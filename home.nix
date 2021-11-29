{ config, pkgs, lib, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "welteki";
  # home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/welteki" else "/home/welteki";

  imports = [ ./modules/home.nix ];
}
