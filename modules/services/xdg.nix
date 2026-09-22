{
  flux.xdg = {
    nixos = {
      xdg = {
        portal.enable = true;
        terminal-exec.enable = true;
      };
    };

    homeManager =
    { config, ... }:
    {
      xdg = {
        enable = true;

        autostart = {
          enable = true;
          readOnly = true;
        };

        userDirs = let
          homeDir = config.home.homeDirectory;
        in {
          enable = true;
          createDirectories = true;
          setSessionVariables = true;

          desktop = null;
          templates = "${homeDir}/Templates";
          music = null;
          publicShare = null;
          projects = "${homeDir}/Projects";
        };
      };

      home.sessionVariables = {
        ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
        CARGO_HOME = "${config.xdg.dataHome}/cargo";
        WINEPREFIX = "${config.xdg.dataHome}/wine";
      };
    };
  };
}
