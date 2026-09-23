{ flux, lib, ... }:
{
  flux.boot.provides = {
    secure.nixos = {
      boot = {
        loader = {
          systemd-boot.enable = lib.mkForce false;

          limine = {
            enable = true;

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
      initrd.verbose = false;

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
