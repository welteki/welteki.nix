{ buildGoModule
, go_1_27
, fetchFromGitHub
, ...
}:

buildGoModule.override { go = go_1_27; } rec {
  pname = "kubetrim";
  version = "v0.0.3";

  src = fetchFromGitHub {
    owner = "alexellis";
    repo = "kubetrim";
    rev = "${version}";
    sha256 = "sha256-uUSvLSk8GiR316CoSCY2eJo3gaa7TYhk/izHiqzLSRs=";
  };

  vendorHash = null;

  subPackages = [ "." ];
}
