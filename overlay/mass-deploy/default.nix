{ buildGoModule
, fetchFromGitHub
, ...
}:

buildGoModule rec {
  pname = "mass-deploy";
  version = "b9a83f9a6d64f957e7fcf2dd31b0d92de13305cb";

  src = fetchFromGitHub {
    owner = "openfaas";
    repo = "mass-deploy";
    rev = "${version}";
    sha256 = "sha256-0jcQ34UHWoRmchJY/ys+pPI6LGhraWMFQbwqGXeCRs8=";
  };

  vendorHash = "sha256-/3Jny2nWdOnRsc53s01IRhvWITt2Ac5URVWtOODTE8Q=";

  CGO_ENABLED = 0;

  subPackages = [ "." ];
}
