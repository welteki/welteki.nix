inputs:

final: prev:
{
  inherit inputs;

  flakeLock = builtins.fromJSON (builtins.readFile ../flake.lock);

  caddy = import ./caddy final;
  nixery = import ./nixery final;

  # Workaround to make gh auth login work untill
  # https://github.com/cli/cli/issues/4955 is fixed
  gh-login = final.writeShellScriptBin "gh-login" ''
    tmp_config_dir=$(${final.coreutils}/bin/mktemp -d gh-login.XXXX)
    
    # Cleanup working dir on shell exit
    trap '${final.coreutils}/bin/rm -rf -- "$tmp_config_dir"' EXIT

    cp $HOME/.config/gh/hosts.yml $tmp_config_dir/hosts.yml

    GH_CONFIG_DIR=$tmp_config_dir ${final.gh}/bin/gh auth login $@

    cp $tmp_config_dir/hosts.yml $HOME/.config/gh/hosts.yml
  '';
}
