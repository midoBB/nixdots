let
  # obtained via `autorandr --fingerprint`
  vm = "--CONNECTED-BUT-EDID-UNAVAILABLE--Virtual1";
  big = "00ffffffffffff004c2d0e1051555a42191f010380351e782a6595a854519c25105054bfef80714f81c0810081809500a9c0b3000101023a801871382d40582c45000f282100001e000000fd00324b1e5512000a202020202020000000fc00533234523335780a2020202020000000ff00483454523630303439360a20200134020313b14690041f13131367030c0010000024011d00bc52d01e20b82855400f282100001e011d007251d01e206e2855000f2821000018011d007251d01e206e2855000f28210000182a4480a070382740302035000f282100001a0000000000000000000000000000000000000000000000000000000000000000000000000e";
  small = "00ffffffffffff004c2d18073032354225140103802c19782ab811a6554b9b25135054bfee80714f81009500810f950f010101010101302a40c86084643018501300bbf91000001e000000fd00384b1e510f000a202020202020000000fc00534d4258323035300a20202020000000ff0048564e5a3930303032300a202001ed02010400011d007251d01e206e285500bbf91000001e011d00bc52d01e20b8285540bbf91000001e8c0ad090204031200c405500bbf9100000188c0ad08a20e02d10103e9600bbf9100000180000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009b";
  aero = "00ffffffffffff0006af966400000000001e0104a51d127803f795a6534aa0260d505400000001010101010101010101010101010101fa3c80b870b0244010103e001eb210000018a72880b870b0244010103e001eb21000001800000000000000000000000000000000000000000002000c2dff103cc80c1820c820202000ac";
in {
  programs.autorandr = {
    enable = true;

    hooks = {
      predetect = {"wait" = "sleep 5";};

      preswitch = {};

      postswitch = {
        "change-dpi" = ''
          #!/bin/bash
          case "$AUTORANDR_CURRENT_PROFILE" in
            *mobile*)
                dconf write /org/mate/desktop/font-rendering/dpi 124.0
                export QT_FONT_DPI=124
              ;;
            *docked*)
                dconf write /org/mate/desktop/font-rendering/dpi 96.0
                export QT_FONT_DPI=96
              ;;
          esac
          feh --randomize --bg-fill ~/.local/share/wallpapers/*
          # i3-msg restart
          polybar-msg cmd restart
        '';
      };
    };

    profiles = {
      "mobile" = {
        fingerprint = {eDP-1 = aero;};

        config = {
          eDP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "1920x1200";
            rate = "60.03";
            rotate = "normal";
          };
        };
      };
      "docked" = {
        fingerprint = {
          HDMI-1 = small;
          DP-1 = big;
          eDP = aero;
        };
        config = {
          DP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
            rate = "60.00";
          };
          HDMI-1 = {
            enable = true;
            crtc = 1;
            primary = false;
            position = "1920x0";
            mode = "1600x900";
            rate = "60.00";
          };
          eDP = {enable = false;};
        };
      };
      "work-docked" = {
        fingerprint = {Virtual1 = vm;};
        config = {
          Virtual1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
            rate = "60.00";
          };
        };
      };
    };
  };
}
