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
        rawtherapee
        digikam
        krita
        birdtray
        pkgs-unstable.thunderbird-bin
        jetbrains.idea-ultimate
        jetbrains.datagrip
        postman
        # office suite
        libreoffice
        #ereader software
        pkgs-unstable.calibre
        # gaming
        # steam-run
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
