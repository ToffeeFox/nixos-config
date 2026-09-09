{ pkgs, ... }:

let
  disks = {
    rootUUID = "983b1082-724b-4108-8226-f70d098dddcf";
    swapUUID = "5c9b5633-7943-4643-b7ca-769ce43444cd";
  };
in
{
  boot = {
    # Bootloader!
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Plymouth Pretty Boot
    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    # Kernel package selection (using latest)
    kernelPackages = pkgs.linuxPackages_latest;

    initrd = {
      systemd.enable = true;

      luks = {
        #fido2support = false;

        devices = {
          "luks-${disks.rootUUID}" = {
            crypttabExtraOpts = [
              "fido2-device=auto"
            ];
            device = "/dev/disk/by-uuid/${disks.rootUUID}";
          };
          "luks-${disks.swapUUID}" = {
            device = "/dev/disk/by-uuid/${disks.swapUUID}";
          };
        };
      };
    };
  };
}
