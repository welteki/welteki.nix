{ buildGoModule
, fetchFromGitHub
, ...
}:

buildGoModule rec {
  pname = "actuated-cli";
  version = "0.0.5";

  src = fetchFromGitHub {
    owner = "self-actuated";
    repo = "actuated-cli";
    rev = "v${version}";
    sha256 = "sha256-RNDy4jadgjLLXBPfK9COKYAKuj4V/7aFOgLJvz3ROqE=";
  };

  vendorSha256 = "sha256-vanKL5s+szW0hduUXGnJNUlyu8wZ2HsBVklIUb/+DLY=";

  ldflags = [
    "-s"
    "-w"
  ];

  CGO_ENABLED = 0;

  subPackages = [ "." ];
}
