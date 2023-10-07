{pkgs, ...}: {
  home.packages = with pkgs; [git-crypt];
  programs.git = {
    enable = true;
    userName = "Mohamed Hamdi";
    userEmail = "haamdi@outlook.com";
    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers decorations";
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-style = "bold yellow";
          file-decoration-style = "none";
        };
      };
    };
    extraConfig = {
      pull.ff = "only";
      core = {
        editor = "nvim";
        whitespace = "fix,-ident-with-non-tab,trailing-space,cr-at-eol";
      };
      init.interactive = "delta --color-only";
      merge.conflictstyle = "diff3";
      credential.helper = "store";
    };
    lfs.enable = true;
    ignores = [".direnv" "result"];
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  programs.gpg.enable = pkgs.stdenv.isLinux;
  services.gpg-agent.enable = pkgs.stdenv.isLinux;
}
