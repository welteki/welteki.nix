{ buildGoModule
, fetchFromGitHub
, ...
}:

buildGoModule rec {
  pname = "actuated-cli";
  version = "0.2.14";

  src = fetchFromGitHub {
    owner = "self-actuated";
    repo = "actuated-cli";
    rev = "v${version}";
    sha256 = "sha256-EIldUfLlhoJtV6fZWvmMUcSrXynWt4uKLawBr26/y/c=";
  };

  vendorHash = null;

  ldflags = [
    "-s"
    "-w"
  ];

  subPackages = [ "." ];
}
