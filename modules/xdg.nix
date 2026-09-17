{
  flux.xdg = {
    nixos.xdg.terminal-exec.enable = true;

    homeManager =
    { config, ... }:
    {
      xdg = {
        enable = true;

        autostart = {
          enable = true;
          readOnly = true;
        };

        userDirs = {
          enable = true;
          createDirectories = true;
          setSessionVariables = true;

          desktop = null;
          templates = "${config.home.homeDirectory}/Templates";
          music = null;
          publicShare = null;
          projects = "${config.home.homeDirectory}/Projects";
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
