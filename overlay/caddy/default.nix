{ buildGoModule, ... }:
buildGoModule {
  pname = "caddy-custom";
  version = "2.8.4";

  src = ./.;

  vendorHash = "sha256-xa5BkYIze8sDt0R6xW4vm7xYqDfxBxUt+GmVAUXf5CY=";

  meta.mainProgram = "caddy";
}
