{ inputs, ... }:
{
  flux.niri._.noctalia = {
    nixos.services.displayManager.noctalia-greeter.enable = true;
    
    homeManager = { pkgs, lib, ... }: {
      xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;
      programs = {
        
        noctalia = {
          enable = true;
          systemd.enable = true;

          settings = {
            theme = {
              mode = "dark";
              source = "community";
              community = "Tokyo Night Storm";
            };

            wallpaper = {
              enabled = true;
              default.path = inputs.self + "/assets/background.png";
            };
          };
        };
        niri.settings.binds =
          let
            msg = cmd: { spawn-sh = "noctalia msg " + cmd; };
          in
          {
            "Mod+Space".action = msg "panel-toggle launcher";
            "Mod+Escape".action = msg "session lock";
            "Mod+V".action = msg "panel-toggle clipboard";
            "Mod+Shift+S".action = msg "screenshot-region";
          };
      };
    };
  };
}