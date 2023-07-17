{
  gaaa = "git add -A .";
  gcaam = "git add -A .; git commit -m";
  c = "clear";
  su = "sudo -i";
  ls = "exa -l --color=always --icons --group-directories-first";
  la = "exa -al --color=always --icons --group-directories-first";
  lt = "exa -T  --level 5 --color=always --group-directories-first";
  left = "exa -l --color=always --icons --group-directories-first --reverse --sort=modified";
  lsblk = "lsblk -o name,mountpoint,label,size,type,uuid";
  df = "df -h";
  cat = "bat -p";
  cpv = "rsync -ah --info=progress2";
  mkdir = "mkdir -pv";
  o = "xdg-open";
  cpc="xclip -sel c < ";
  tm = "tmux attach || tmux";
  guncommit = "git reset --soft HEAD^";
  gd = "git diff";
  # Serve a folder
  servethis = "python3 -m http.server";
  vim = "nvim";
  vi = "nvim";
  google-chrome = "google-chrome-stable";
}
