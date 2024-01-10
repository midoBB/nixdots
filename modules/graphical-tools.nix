{
  pkgs,
  pkgs-unstable,
  workMode,
  ...
}: {
  home.packages = with pkgs;
    [obsidian mate.engrampa synology-drive-client google-chrome]
    ++ (
      if workMode
      then [
        jetbrains.goland
        jetbrains.idea-community
      ]
      else [
        trayscale
        rawtherapee
        digikam
        krita
        birdtray
        pkgs-unstable.thunderbird-bin
        jetbrains.idea-ultimate
        jetbrains.datagrip
        emacs29
        sublime4
        # office suite
        libreoffice
        #ereader software
        pkgs-unstable.calibre
        # gaming
        (steam.override {extraPkgs = pkgs: [openssl_1_1];}).run
        #torrent
        transmission-gtk
      ]
    );
  /*
  xdg.configFile."microsoft-edge/NativeMessagingHosts/net.downloadhelper.coapp.json".source =
  config.lib.file.mkOutOfStoreSymlink "${pkgs.nur.repos.wolfangaukang.vdhcoapp}/etc/opt/chrome/native-messaging-hosts/net.downloadhelper.coapp.json";
  */
  home.file.".ideavimrc".source = ./programming/ideavimrc.txt;
}
