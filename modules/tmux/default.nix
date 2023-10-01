{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      /*
       {
      /*
      plugin = dracula;
      */
      /*
           extraConfig = ''
          set -g @dracula-plugins "battery time"
          set -g @dracula-show-powerline true
          set -g @dracula-military-time true
        '';
      }
      */
    ];

    extraConfig = ''
      #!/usr/bin/env bash

      # TokyoNight colors for Tmux

          set -g mode-style "fg=#7aa2f7,bg=#3b4261"

          set -g message-style "fg=#7aa2f7,bg=#3b4261"
          set -g message-command-style "fg=#7aa2f7,bg=#3b4261"

          set -g pane-border-style "fg=#3b4261"
          set -g pane-active-border-style "fg=#7aa2f7"

          set -g status "on"
          set -g status-justify "left"

          set -g status-style "fg=#7aa2f7,bg=#1f2335"

          set -g status-left-length "100"
          set -g status-right-length "100"

          set -g status-left-style NONE
          set -g status-right-style NONE

          set -g status-left "#[fg=#1d202f,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#1f2335,nobold,nounderscore,noitalics]"
          set -g status-right "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#1f2335] #{prefix_highlight} #[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %I:%M %p #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1d202f,bg=#7aa2f7,bold] #h "
          if-shell '[ "$(tmux show-option -gqv "clock-mode-style")" == "24" ]' {
            set -g status-right "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#1f2335] #{prefix_highlight} #[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %H:%M #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1d202f,bg=#7aa2f7,bold] #h "
          }

          setw -g window-status-activity-style "underscore,fg=#a9b1d6,bg=#1f2335"
          setw -g window-status-separator ""
          setw -g window-status-style "NONE,fg=#a9b1d6,bg=#1f2335"
          setw -g window-status-format "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]"
          setw -g window-status-current-format "#[fg=#1f2335,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]"

      # tmux-plugins/tmux-prefix-highlight support
          set -g @prefix_highlight_output_prefix "#[fg=#e0af68]#[bg=#1f2335]#[fg=#1f2335]#[bg=#e0af68]"
          set -g @prefix_highlight_output_suffix ""
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
