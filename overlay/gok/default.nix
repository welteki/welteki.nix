{ buildGoModule
, fetchFromGitHub
, ...}:

buildGoModule rec {
  pname = "gok";
  version = "dceb56ee3943e1e5aefd16f6f5c2bfeb91b36ded";

  src = fetchFromGitHub {
    owner = "gokrazy";
    repo = "tools";
    rev = "${version}";
    hash = "sha256-ZchOUoNxZMC9Bfeen+2ibhIg1OloSCq/N3lFzwYAAvM=";
  };

  vendorSha256 = "sha256-dZHHpSUtKq/QCU8XG4cz0Zs1px293+4F+2qp8tNsQUs=";

  CGO_ENABLED = 0;

  subPackages = [ "cmd/gok" ];
}