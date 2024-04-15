{ config, pkgs, lib, ... }:
let
  aliases = {
    g = "git";
    lg = "lazygit";
    ofpasswd = "kubectl get secret -n openfaas basic-auth -o jsonpath='{.data.basic-auth-password}' | base64 --decode; echo";
    oflogin = "kubectl get secret -n openfaas basic-auth -o jsonpath='{.data.basic-auth-password}' | base64 --decode | faas-cli login --username admin --password-stdin";
    kctl = "kubectl";
    kctx = "kubectx";
    kns = "kubens";
  };
in
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
        signoff = ''!f() { git rebase --signoff @~''${1:-1}; }; f'';
      };
      ignores = [
        # macOS.gitignore source:https://github.com/github/gitignore/blob/master/Global/macOS.gitignore
        # General
        ".DS_Store"
        ".AppleDouble"
        ".LSOverride"

        # Thumbnails
        "._*"

        # Lazygit config
        "lg_config.yml"
      ];
      extraConfig = {
        init.defaultBranch = "main";
      };
      includes = [
        {
          path = pkgs.writeText "git-openfaas" ''
            [user]
                name = Han Verstraete (OpenFaaS Ltd)
                email = han@openfaas.com
          '';
          condition = "gitdir:~/code/openfaas/";
        }
      ];
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    tmux = {
      enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      shellAliases = aliases;
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

    bash = {
      enable = true;
      shellAliases = aliases;
    };

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
          disabled = false;
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

    vim.enable = true;

    fzf.enable = true;
    bat.enable = true;
    jq.enable = true;
    eza = {
      enable = true;
      enableBashIntegration = true;
    };
    lazygit.enable = true;
  };

  home.sessionPath = [
    "$HOME/.arkade/bin/"
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.packages = [
    pkgs.arkade
    pkgs.devenv
  ];

  nix = {
    enable = true;
    package = pkgs.nixVersions.nix_2_18;
    settings = {
      experimental-features = "nix-command flakes";
      builders = "ssh://nix@pi8.local aarch64-linux";
      sandbox = true;
      substituters = "https://cache.nixos.org https://welteki.cachix.org https://devenv.cachix.org";
      trusted-public-keys = ''cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= welteki.cachix.org-1:zb0txiNEbjq9Fx7svp4LhTgFIQHKSa5ESi7QlLFjjQY= devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw='';
    };
  };
}
