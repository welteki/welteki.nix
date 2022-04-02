inputs:

{ config, lib, pkgs, ... }:

{
  # https://github.com/msteen/nixos-vscode-server
  imports = [ inputs.vscode-server ];

  services.vscode-server.enable = true;
}
