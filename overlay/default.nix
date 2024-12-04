inputs:

final: prev:
let
  inherit (inputs) devenv inlets;
in
{
  devenv = devenv.packages.${final.system}.devenv;
  inlets = inlets.packages.${final.system}.inlets-pro;
  actuated-cli = import ./actuated-cli final;
  caddy = import ./caddy final;
  mass-deploy = import ./mass-deploy final;
  kubetrim = import ./kubetrim final;
}
