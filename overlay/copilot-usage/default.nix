{ rustPlatform
, fetchFromGitHub
, ...
}:

rustPlatform.buildRustPackage rec {
  pname = "copilot-usage";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "kevingosse";
    repo = "copilot-usage";
    rev = "99516def79e785f50ac43e6b0856447bf20cf1d3";
    hash = "sha256-xjsMPMAbajae8Kx8LrpQeH0vH8xDVDKG3ev8c+sQOZ4=";
  };

  cargoHash = "sha256-0QMWdDcnkXoTPK6Dqlj/ASLAY+6D5x0KkWJ/jLIwA+8=";
}
