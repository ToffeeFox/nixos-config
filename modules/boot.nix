{ flux, lib, ... }:
{
  flux.boot.provides = {
    secure.nixos = { pkgs, ... }: {
      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        initrd.luks.fido2Support = false;
        loader = {
          systemd-boot.enable = lib.mkForce false;
          # efi.canTouchEfiVariables = true;

          limine = {
            enable = true;
            maxGenerations = 32;
            secureBoot.enable = true;

            style = {
              interface = {
                branding = "Lukida's Customized Limine Bootloader";
              };
            };
          };
        };
      };
    };

    graphical.nixos.boot = {
      plymouth = {
        enable = true;
        theme = "bgrt";
      };

      consoleLogLevel = 3;
      initrd.verbose = true;

      initrd.systemd.enable = true;

      kernelParams = [
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
    };
  };
}
