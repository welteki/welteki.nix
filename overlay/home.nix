inputs:

final: prev:
let
  inherit (inputs) devenv;
in
{
  devenv = devenv.packages.${final.system}.devenv;

  # lazygit =
  #   final.writeShellScriptBin "lazygit" ''
  #     if [ -e ./lg_config.yml ]; then
  #       ${prev.lazygit}/bin/lazygit --use-config-file=$HOME/.config/lazygit/config.yml,./lg_config.yml $@
  #     else
  #       ${prev.lazygit}/bin/lazygit $@
  #     fi
  #   '';
}
