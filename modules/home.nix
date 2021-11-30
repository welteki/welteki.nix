{ config, pkgs, lib, ... }:
{
  programs = {
    git = {
      enable = true;
      userName = "Han Verstraete";
      userEmail = "welteki@pm.me";
      aliases = {
        co = "checkout";
        ci = "commit";
        cia = "commit --amend";
        sci = "commit -S";
        scia = "commit -S --amend";
        st = "status";
        b = "branch";
        pu = "push";
        mff = "merge --ff-only";
        l = "log";
        lo = "log --oneline";
      };
      ignores = [
        # macOS.gitignore source:https://github.com/github/gitignore/blob/master/Global/macOS.gitignore
        # General
        ".DS_Store"
        ".AppleDouble"
        ".LSOverride"

        # Thumbnails
        "._*"
      ];
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      plugins = [
        {
          name = "zsh-syntax-highlighting";
          file = "zsh-syntax-highlighting.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.7.1";
            sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
          };
        }
      ];
    };

    bash.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      settings = {
        docker_context = {
          symbol = " ";
        };
        git_branch = {
          symbol = " ";
        };
        golang = {
          symbol = " ";
        };
        java = {
          symbol = " ";
        };
        kubernetes = {
          symbol = "ﴱ ";
        };
        nix_shell = {
          symbol = " ";
        };
        nodejs = {
          symbol = " ";
        };
        package = {
          symbol = " ";
        };
        python = {
          symbol = " ";
        };
        terraform = {
          symbol = "  ";
        };
      };
    };

    gh.enable = true;
    bat.enable = true;
    jq.enable = true;
    exa = {
      enable = true;
      enableAliases = true;
    };
    lazygit.enable = true;
  };
}
