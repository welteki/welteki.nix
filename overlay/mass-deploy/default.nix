{ buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mass-deploy";
  version = "6c0e027952e811b3ea2c8a28870fd4f128881168";

  src = fetchFromGitHub {
    owner = "openfaas";
    repo = "mass-deploy";
    rev = "${version}";
    sha256 = "sha256-Gxyf/mnJCad3Elrh7iQB9l4M1anD5gIXmxguNw0bqmY=";
  };

  vendorHash = "sha256-XUfP+Gg90Yo+/FcXRijAWpqWzqhmYZydfn1nM+4t5pk=";

  env.CGO_ENABLED = false;

  subPackages = [ "." ];
}
