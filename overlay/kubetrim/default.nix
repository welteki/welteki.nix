{ buildGoModule
, fetchFromGitHub
, ...
}:

buildGoModule rec {
  pname = "kubetrim";
  version = "v0.0.2";

  src = fetchFromGitHub {
    owner = "alexellis";
    repo = "kubetrim";
    rev = "${version}";
    sha256 = "sha256-XYsj4wbVNPfPht9Odqk2FjlhS2uJUQS7vLRUd5rAht4=";
  };

  vendorHash = "sha256-m9OuVFlD4F170Q6653HdvUhdULjR2cAttLsUN03XIXo=";

  subPackages = [ "." ];
}
