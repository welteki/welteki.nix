inputs:

final: prev:
let inherit (inputs) devenv;
in {
  devenv = devenv.packages.${final.stdenv.hostPlatform.system}.devenv;
  inlets = final.inlets-pro;
  actuated-cli = import ./actuated-cli final;
  caddy = import ./caddy final;
  hunk = import ./hunk inputs final;
  herdr = inputs.herdr.packages.${final.stdenv.hostPlatform.system}.herdr;
  mass-deploy = import ./mass-deploy final;
  kubetrim = import ./kubetrim final;
}
