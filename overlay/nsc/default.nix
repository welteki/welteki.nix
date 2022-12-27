{ buildGoModule
, fetchFromGitHub
, ...
}:

buildGoModule rec {
  pname = "nsc";
  version = "2.7.6";

  src = fetchFromGitHub {
    owner = "nats-io";
    repo = "nsc";
    rev = "v${version}";
    sha256 = "sha256-aieUCQ5JVJQs4RoTGaXwfTv3xC1ozSsQyfCLsD245go=";
  };

  vendorSha256 = "sha256-gDwppx0ORG+pXzTdGtUVbiFyTD/P7avt+/V89Gl0QYY=";

  ldflags = [
    "-s"
    "-w"
    "-X main.commit=ref/tags/${version}"
    "-X main.version=${version}"
    "-X main.builtBy=nix"
  ];

  CGO_ENABLED = 0;

  subPackages = [ "." ];
}
