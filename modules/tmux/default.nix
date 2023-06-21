{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-plugins "battery time"
          set -g @dracula-show-powerline true
          set -g @dracula-military-time true
        '';
      }
    ];

    extraConfig = ''
      set -g mouse off
      set-option -g focus-events on
      set -g mode-keys vi
      set -g status-keys vi
      set -s set-clipboard off
      bind -T root      C-S-v run-shell "xsel -o -b | tmux load-buffer - && tmux paste-buffer"
      bind -T copy-mode C-S-c send-keys -X copy-pipe-and-cancel "xsel -i -b"
      bind-key -T copy-mode-vi Enter send-keys -X copy-pipe "xclip -sel clip -i" \; send-keys -X clear-selection
      bind -r h select-pane -L
      bind -r l select-pane -R
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind-key -r f run-shell "tmux neww tmux-sessionizer"
      bind c new-window -c "#{pane_current_path}"
      set -g default-terminal "tmux-256color"
      set-option -sa terminal-overrides ',xterm-256color:RGB'
      set -ga terminal-overrides ",*256col*:Tc"           # true colous support
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
    '';
  };
}
