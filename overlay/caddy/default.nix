{ buildGoModule, ... }:
buildGoModule {
  pname = "caddy-custom";
  version = "2.11.4";

  src = ./.;

  vendorHash = "sha256-QnhJJIxUHJItvXP2jz9jpGy8eFwob/Dm+TghtR6TTRU=";

  meta.mainProgram = "caddy";
}
