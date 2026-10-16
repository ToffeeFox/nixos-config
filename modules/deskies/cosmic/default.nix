{ flux, ... }:
{
  flux.deskies.cosmic = {
    includes = [
      flux.wayland._.base
    ];

    nixos = { ... }: {
      services = {
        desktopManager.cosmic = {
          enable = true;
          xwayland.enable = true;
        };

        # greetd-based greeter from the COSMIC project
        displayManager = {
          cosmic-greeter.enable = true;
          defaultSession = "cosmic";
        };
      };
    };
  };
}
