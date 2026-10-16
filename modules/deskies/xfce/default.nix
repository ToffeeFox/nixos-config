{ __findFile, flux, lib, den, ... }:
{
  flux.deskies.xfce = {
    includes = [
      <flux/xserver/base>
    ];

    nixos = { pkgs, ... }: {
      # Remove the following default packages from the XFCE desktop
      environment.xfce.excludePackages = with pkgs; [
        mousepad # Text Editor
        parole # Media Player
        ristretto # Image Viewer
      ];

      services = {
        xserver = {
          desktopManager = {
            xfce = {
              enable = true;
            };
          };
        };

        displayManager.defaultSession = "xfce";
      };
    };
  };
}
