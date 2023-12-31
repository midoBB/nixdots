format:
    #!/usr/bin/env zsh
    alejandra **/*.nix
    stylua **/*.lua
user:
    apply-user
nvim:
    nvim --headless "+Lazy! sync" +qa
system:
    apply-system
update:
    update-dots
both:
    apply-system && apply-user
all:
    update-dots && apply-system && apply-user
