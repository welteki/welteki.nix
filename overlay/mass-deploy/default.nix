{ buildGoModule, go_1_27, fetchFromGitHub, ... }:

buildGoModule.override { go = go_1_27; } rec {
  pname = "mass-deploy";
  version = "df56070d5baa8eb5a99bcfff9e695d6336cec72e";

  src = fetchFromGitHub {
    owner = "openfaas";
    repo = "mass-deploy";
    rev = "${version}";
    sha256 = "sha256-2EEWnhxpcn2XUPnXLimCXEQ5vZ30H5w3vkhgXQtuLyQ=";
  };

  vendorHash = null;

  env.CGO_ENABLED = false;

  subPackages = [ "." ];
}
