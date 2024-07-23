{ buildGoModule, ... }:
buildGoModule {
  pname = "caddy-custom";
  version = "2.8.4";

  src = ./.;

  vendorHash = "sha256-E38arFv5k8gRh/eiAA2u9EYxWpyMLCIogHIZVJrMuq4=";
}
