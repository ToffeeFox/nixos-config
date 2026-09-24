{ den, flux, ... }:
let
  disks = {
    rootUUID = "983b1082-724b-4108-8226-f70d098dddcf";
    swapUUID = "5c9b5633-7943-4643-b7ca-769ce43444cd";
  };
in
{
  den.aspects.stellarfox.nixos = {
    fileSystems."/" = {
      device = "/dev/mapper/luks-${disks.rootUUID}";
      fsType = "btrfs";
    };

    boot.initrd.luks.devices = {
      "luks-${disks.rootUUID}" = {
        crypttabExtraOpts = [
          "fido2-device=auto"
        ];
        device = "/dev/disk/by-uuid/${disks.rootUUID}";
      };

      "luks-${disks.swapUUID}" = {
        crypttabExtraOpts = [
          "fido2-device=auto"
        ];
        device = "/dev/disk/by-uuid/${disks.swapUUID}";
      };
    };

    fileSystems."/nix" = {
      device = "/dev/mapper/luks-${disks.rootUUID}";
      fsType = "btrfs";
      options = [
        "subvol=nix"
      ];
    };

    fileSystems."/home" = {
      device = "/dev/mapper/luks-${disks.rootUUID}";
      fsType = "btrfs";
      options = [
        "subvol=home"
      ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/B288-F330";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [
      {
        device = "/dev/mapper/luks-${disks.swapUUID}";
      }
    ];
  };
}
