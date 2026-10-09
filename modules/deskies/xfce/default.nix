{ __findFile, flux, lib, den, ... }:
{
  flux.deskies.xfce = {
    includes = [
      <flux/xserver/base>
    ];

    nixos = { pkgs, lib, ... }: {
      # Remove the following default packages from the XFCE desktop
      environment.xfce.excludePackages = with pkgs.xfce; [
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
