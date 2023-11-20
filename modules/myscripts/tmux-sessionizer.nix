{pkgs, ...}: let
  tmux-sessionizer = pkgs.writeScriptBin "tmux-sessionizer" ''
    #!/usr/bin/env bash
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$( (find ~/Workspace ~/.config ~/ ~/Drive -mindepth 1 -maxdepth 1 -type d; find "$HOME/Drive/Documents/" "$HOME/Drive/Notes/" -mindepth 1 -maxdepth 3 \( ! -regex '.*/\..*' \) -type d) 2>/dev/null|fzf)
    fi

    if [[ -z $selected ]]; then
        exit 0
    fi

    selected_name=$(basename "$selected" | tr . _)
    tm() {
      zoxide add "$selected"
      if [ -z "$selected" ]; then
        tmux switch-client -l "$selected_name"
      else
        if [ -z "$TMUX" ]; then
          tmux new-session -As "$selected_name" -c "$selected"
        else
          if ! tmux has-session -t "$selected_name" 2>/dev/null; then
            TMUX= tmux new-session -ds "$selected_name" -c "$selected"
          fi
          tmux switch-client -t "$selected_name"
        fi
      fi
    }
    tm
  '';
in {
  home.packages = [tmux-sessionizer pkgs.coreutils pkgs.findutils pkgs.fzf pkgs.tmux];
}
