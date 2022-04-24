final: prev:
{
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

        ldflags = old.ldflags ++ [ "-X main.version=${version}" ];
      });
    in
    final.writeShellScriptBin "lazygit" ''
      if [ -e ./lg_config.yml ]; then
        ${lazygit}/bin/lazygit --use-config-file=$HOME/.config/lazygit/config.yml,./lg_config.yml $@
      else
        ${lazygit}/bin/lazygit $@
      fi
    '';
}
