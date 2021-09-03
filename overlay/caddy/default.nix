{ buildGoModule, ... }:
buildGoModule {
  pname = "caddy-custom";
  version = "2.4.4";

  src = ./.;

  vendorSha256 = "1ppx5z4ab7rrilsggs5j3p3nkjflfwliyxjq0ns8zvqlqviz3cvg";
}
