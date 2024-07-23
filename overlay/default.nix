inputs:

final: prev:
let
  inherit (inputs) devenv;
in
{
  devenv = devenv.packages.${final.system}.devenv;
  actuated-cli = import ./actuated-cli final;
  caddy = import ./caddy final;
  mass-deploy = import ./mass-deploy final;
}
