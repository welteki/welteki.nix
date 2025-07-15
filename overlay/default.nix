inputs:

final: prev:
let inherit (inputs) devenv inlets;
in {
  devenv = devenv.packages.${final.system}.devenv;
  inlets = inlets.packages.${final.system}.inlets-pro;
  actuated-cli = import ./actuated-cli final;
  caddy = import ./caddy final;
  mass-deploy = import ./mass-deploy final;
  kubetrim = import ./kubetrim final;

  nats-server-dev = prev.nats-server.overrideAttrs (old: rec {
    pname = "nats-server-dev";
    version = "26797a8";

    src = final.fetchFromGitHub {
      owner = "nats-io";
      repo = "nats-server";
      rev = "${version}";
      hash = "sha256-Pir1Z8hIbUH1fKW4O9RwjoxnloABMAtFmipZltRFl+U=";
    };

    vendorHash = "sha256-VXwyGqPlROKK3K0Bu74L/xJjqAT5+JInAmXNmlVXsWQ=";
  });
}
