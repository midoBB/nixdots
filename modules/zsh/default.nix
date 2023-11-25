{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  programs = {
    exa = {
      enable = true;
      package = pkgs-unstable.eza;
    };
    nix-index.enable = true;
    atuin = {
      enable = true;
      package = pkgs-unstable.atuin;
      enableZshIntegration = true;
      settings = {
        inline_height = 20;
        search_mode = "skim";
        filter_mode_shell_up_key_binding = "directory";
      };
    };
    zoxide = {
      enable = true;
      options = ["--hook pwd"];
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      fileWidgetCommand = "fd --type f --color=never --hidden";
      fileWidgetOptions = ["--preview 'bat --color=always --line-range :50 {}'"];
      defaultCommand = "fd --type f --color=never --hidden";
      changeDirWidgetCommand = "fd --type d . --color=never --hidden";
      changeDirWidgetOptions = ["--preview 'tree -C {} | head -50'"];
      defaultOptions = [
        "--color 'fg:#a9b1d6'" # Text
        "--color 'bg:#24283b'" # Background
        "--color 'preview-fg:#a9b1d6'" # Preview window text
        "--color 'preview-bg:#24283b'" # Preview window background
        "--color 'hl:#41a6b5'" # Highlighted substrings
        "--color 'fg+:#c0caf5'" # Text (current line)
        "--color 'bg+:#1f2335'" # Background (current line)
        "--color 'gutter:#24283b'" # Gutter on the left (defaults to bg+)
        "--color 'hl+:#41a6b5'" # Highlighted substrings (current line)
        "--color 'info:#e0af68'" # Info line (match counters)
        "--color 'border:#1abc9c'" # Border around the window (--border and --preview)
        "--color 'prompt:#e0af68'" # Prompt
        "--color 'pointer:#1abc9c'" # Pointer to the current line
        "--color 'marker:#1abc9c'" # Multi-select marker
        "--color 'spinner:#1abc9c'" # Streaming input indicator
        "--color 'header:#41a6b5'" # Header
      ];
    };
    tealdeer = {
      enable = true;
      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {auto_update = true;};
      };
    };
    zsh = {
      enable = true;
      defaultKeymap = "viins";
      history = {
        extended = true;
        size = 102400;
        save = 102400;
        ignoreDups = true;
        expireDuplicatesFirst = true;
        share = true;
        ignoreSpace = true;
        ignorePatterns = ["ls" "cd *" "pwd" "exit" "sudo reboot" "history"];
      };
      plugins = [
        {
          name = "fzf-tab";
          file = "fzf-tab.plugin.zsh";
          src = builtins.fetchGit {
            url = "https://github.com/Aloxaf/fzf-tab/";
            rev = "fd25464ed8159c156582b1ee16faefe79fc934f2";
          };
        }
        {
          name = "forgit";
          file = "forgit.plugin.zsh";
          src = builtins.fetchGit {
            url = "https://github.com/wfxr/forgit.git";
            rev = "801239658718863b9c6e0ba21d027cb0caccd465";
          };
        }
        {
          name = "alias-tips";
          file = "alias-tips.plugin.zsh";
          src = builtins.fetchGit {
            url = "https://github.com/djui/alias-tips/";
            rev = "8fc0d2f9b480991f78ce67c49621731d0336b22f";
          };
        }
        {
          name = "nix-zsh";
          file = "nix-zsh-completions.plugin.zsh";
          src = builtins.fetchGit {
            url = "https://github.com/nix-community/nix-zsh-completions/";
            rev = "6a1bfc024481bdba568f2ced65e02f3a359a7692";
          };
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./p10k;
          file = "p10k.zsh";
        }
      ];
      initExtra = ''
        bindkey -s ^F "tmux-sessionizer\n"
        #Copy to system clipboard from VI mode
        function vi-yank-xclip {
          zle vi-yank
          echo "$CUTBUFFER" | xclip -i
        }
        zle -N vi-yank-xclip
        bindkey -M vicmd 'y' vi-yank-xclip

        # Ctrl+Backspace: kill the word backward
        bindkey -M emacs '^H' backward-kill-word
        bindkey -M viins '^H' backward-kill-word
        bindkey -M vicmd '^H' backward-kill-word

        # Ctrl+Delete: kill the word forward
        bindkey -M emacs '^[[3;5~' kill-word
        bindkey -M viins '^[[3;5~' kill-word
        bindkey -M vicmd '^[[3;5~' kill-word
      '';
      initExtraBeforeCompInit = ''
        # p10k instant prompt
        export JAVA_HOME=$(readlink -e $(type -p javac) | sed  -e 's/\/bin\/javac//g')
        P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
        [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
      '';
      sessionVariables = {
        TERM = "xterm-256color";
        EDITOR = "nvim";
        VISUAL = "nvim";
        PAGER = "less";
        MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      };
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      shellAliases = import ./aliases.nix;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "vi-mode"
          "git"
          "docker"
          "docker-compose"
          "pyenv"
          "extract"
          "pip"
          "sudo"
          "zsh-interactive-cd"
        ];
      };
    };
  };
}
