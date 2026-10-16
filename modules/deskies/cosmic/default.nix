{ flux, ... }:
{
  flux.deskies.cosmic = {
    includes = [
      flux.wayland._.base
    ];

    nixos = { pkgs, ... }: {
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

      environment.cosmic.excludePackages = with pkgs; [
        cosmic-edit # I prefer KATE
        # cosmic-viewer
        cosmic-player # I rather like VLC
        cosmic-term # I prefer Alacritty, plus CosmicTerm doesn't support nerdfonts
        # Or, it is possible I am not setting it up correctly
      ];
    };
  };
}
