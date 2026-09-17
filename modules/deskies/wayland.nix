{
  flux.wayland._.base =
  { host, ... }:
  {
    nixos =
      { pkgs, lib, ... }:
      {
        programs = {
          dconf.enable = true;
          appimage = {
            enable = true;
            binfmt = true;
          };
        };

        environment = {
          systemPackages = [
            pkgs.wl-clipboard
            pkgs.waypipe
          ];

          sessionVariables = {
            NIXOS_OZONE_WL = "1";
            XCURSOR_SIZE = lib.mkForce (builtins.ceil (32 * host.primaryDisplay.scaling));
          };
        };
      };

    homeManager =
      { config, ... }:
      {
        qt.enable = true;
        gtk = {
          enable = true;
          gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
          gtk3.bookmarks = [
            "file:///home/saluki/Downloads Downloads"
            "file:///home/saluki/Documents Documents"
            "file:///home/saluki/Pictures Pictures"
            "file:///home/saluki/Videos Videos"
          ];
        };
      };
  };
}
