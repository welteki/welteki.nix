{ buildGoModule
, fetchFromGitHub
, ...
}:

buildGoModule rec {
  pname = "actuated-cli";
  version = "0.2.17";

  src = fetchFromGitHub {
    owner = "self-actuated";
    repo = "actuated-cli";
    rev = "v${version}";
    sha256 = "sha256-7CXRYewF5y8vt2w6WIkDV1b0EXo1XvFwFzlMMwg2SWI=";
  };

  vendorHash = null;

  ldflags = [
    "-s"
    "-w"
  ];

  subPackages = [ "." ];
}
