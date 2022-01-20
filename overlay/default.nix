inputs:

final: prev:
{
  inherit inputs;

  flakeLock = builtins.fromJSON (builtins.readFile ../flake.lock);

  caddy = import ./caddy final;
  nixery = import ./nixery final;

  lazygit =
    let
      lazygit = prev.lazygit.overrideAttrs (old: rec {
        pname = "lazygit";
        version = "0.32.2";

        src = final.fetchFromGitHub {
          owner = "jesseduffield";
          repo = pname;
          rev = "v${version}";
          sha256 = "sha256-tawsBfHz6gq8va9YLtCwp9Ec8EWcvhdbYwdVtvvtJeY=";
        };
      });
    in
    final.writeShellScriptBin "lazygit" ''
      if [ -e ./lg_config.yml ]; then
        ${lazygit}/bin/lazygit --use-config-file=$HOME/.config/lazygit/config.yml,./lg_config.yml $@
      else
        ${lazygit}/bin/lazygit $@
      fi
    '';

  # Workaround to make gh auth login work untill
  # https://github.com/cli/cli/issues/4955 is fixed
  gh-login = final.writeShellScriptBin "gh-login" ''
    tmp_config_dir=$(${final.coreutils}/bin/mktemp -p /tmp -d gh-login.XXXX)
    
    # Cleanup working dir on shell exit
    trap '${final.coreutils}/bin/rm -rf -- "$tmp_config_dir"' EXIT

    if [ ! -z "$GH_CONFIG_DIR"]; then
      gh_hosts_config=$GH_CONFIG_DIR/hosts.yml
    elif [ ! -z "$XDG_CONFIG_HOME" ]; then
      gh_hosts_config=$XDG_CONFIG_HOME/gh/hosts.yml
    else
      gh_hosts_config=$HOME/.config/gh/hosts.yml
    fi

    [ -f "$gh_hosts_config" ] && cp $gh_hosts_config $tmp_config_dir/hosts.yml

    GH_CONFIG_DIR=$tmp_config_dir ${final.gh}/bin/gh auth login $@

    [ -f "$tmp_config_dir/hosts.yml" ] && cp $tmp_config_dir/hosts.yml $gh_hosts_config
  '';
}
