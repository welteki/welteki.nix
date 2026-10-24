{ buildGoModule, go_1_27, ... }:
buildGoModule.override { go = go_1_27; } {
  pname = "caddy-custom";
  version = "2.11.7";

  src = ./.;

  vendorHash = "sha256-aVR4Yg/qw2KMJRxhtqd9pMemuKOx6X9QQZOLby8F5rE=";

  meta.mainProgram = "caddy";
}
