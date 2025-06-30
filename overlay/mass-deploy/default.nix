{ buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mass-deploy";
  version = "8871a682125977929a7faf10baf930ef926ce83f";

  src = fetchFromGitHub {
    owner = "openfaas";
    repo = "mass-deploy";
    rev = "${version}";
    sha256 = "sha256-nxPZIPyUUAm7Y/Z2Ddvs1jTS7qXgn4LkGCJ+ufEdICI=";
  };

  vendorHash = "sha256-cM43Xos+Zi71tpkgBz1zr8yA5iek+vO9R1XCCwx4TyU=";

  env.CGO_ENABLED = false;

  subPackages = [ "." ];
}
