{ buildGoModule
, fetchFromGitHub
, ...
}:

buildGoModule rec {
  pname = "kubetrim";
  version = "v0.0.1-rc4";

  src = fetchFromGitHub {
    owner = "alexellis";
    repo = "kubetrim";
    rev = "${version}";
    sha256 = "sha256-ZEHNv4gUz/87eapSOJKA3OR8LSHgkGJUg9Rm7DQvULI=";
  };

  vendorHash = "sha256-m9OuVFlD4F170Q6653HdvUhdULjR2cAttLsUN03XIXo=";

  CGO_ENABLED = 0;

  subPackages = [ "." ];
}
