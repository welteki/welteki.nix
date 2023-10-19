{ buildGoModule
, fetchFromGitHub
, ...
}:

buildGoModule rec {
  pname = "mass-deploy";
  version = "410dfd882f2f3eb967a5e69f37246d5f8b68d573";

  src = fetchFromGitHub {
    owner = "openfaas";
    repo = "mass-deploy";
    rev = "${version}";
    sha256 = "sha256-zdmxLAzxh7rgR7/EU1/2KF3CPMqZPxZHsyIrqRMl6Zc=";
  };

  vendorSha256 = "sha256-/3Jny2nWdOnRsc53s01IRhvWITt2Ac5URVWtOODTE8Q=";

  CGO_ENABLED = 0;

  subPackages = [ "." ];
}