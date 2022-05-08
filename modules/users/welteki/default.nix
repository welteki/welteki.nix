{ ... }:

{
  home-manager.users.welteki = {
    imports = [
      ../../home.nix
    ];

    programs = {
      firefox.enable = true;
      vscode.enable = true;
    };
  };
}
