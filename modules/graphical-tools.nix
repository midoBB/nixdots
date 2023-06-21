{
  pkgs,
  config,
  workMode,
  ...
}: {
  home.packages = with pkgs;
    [
      obsidian
      mate.engrampa
      synology-drive-client
      microsoft-edge
      google-chrome
    ]
    ++ (
      if workMode
      then [
        jetbrains.goland
        jetbrains.idea-community
      ]
      else [
        birdtray
        thunderbird-bin
        jetbrains.idea-ultimate
        jetbrains.datagrip
        postman
        # office suite
        wpsoffice
        #ereader software
        calibre
        # gaming
        steam-run
        #torrent
        transmission-gtk
      ]
    );
  xdg.configFile."microsoft-edge/NativeMessagingHosts/net.downloadhelper.coapp.json".source =
    config.lib.file.mkOutOfStoreSymlink "${pkgs.nur.repos.wolfangaukang.vdhcoapp}/etc/opt/chrome/native-messaging-hosts/net.downloadhelper.coapp.json";
  home.file.".ideavimrc".source = ./programming/ideavimrc.txt;
}
