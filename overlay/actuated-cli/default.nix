{ buildGoModule
, fetchFromGitHub
, ...
}:

buildGoModule rec {
  pname = "actuated-cli";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "self-actuated";
    repo = "actuated-cli";
    rev = "v${version}";
    sha256 = "sha256-YyE3JEZTjXADQXK3fBjCCiaKV84Q5PvXz/5jNULHnS0=";
  };

  vendorHash = "sha256-wVQwmAaPsGGaJCPmkCKPtdJMzVDhJsEeh7JasBVBX1E=";

  ldflags = [
    "-s"
    "-w"
  ];

  CGO_ENABLED = 0;

  subPackages = [ "." ];
}
