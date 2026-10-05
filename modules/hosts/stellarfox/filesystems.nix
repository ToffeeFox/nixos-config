{ den, flux, ... }:
let
  disks = {
    luksPrefix = "/dev/mapper/luks-";
    stdPrefix = "/dev/disk/by-uuid/";

    bootUUID = "B288-F330";
    rootUUID = "983b1082-724b-4108-8226-f70d098dddcf";
    swapUUID = "5c9b5633-7943-4643-b7ca-769ce43444cd";
  };
in
{
  den.aspects.stellarfox.nixos = {
    fileSystems."/" = {
      device = "${disks.luksPrefix}${disks.rootUUID}";
      fsType = "btrfs";
    };

    boot.initrd.luks.devices = {
      "luks-${disks.rootUUID}" = {
        crypttabExtraOpts = [
          "fido2-device=auto"
        ];
        device = "${disks.stdPrefix}${disks.rootUUID}";
      };

      "luks-${disks.swapUUID}" = {
        crypttabExtraOpts = [
          "fido2-device=auto"
        ];
        device = "${disks.stdPrefix}${disks.swapUUID}";
      };
    };

    fileSystems."/nix" = {
      device = "${disks.luksPrefix}${disks.rootUUID}";
      fsType = "btrfs";
      options = [
        "subvol=nix"
      ];
    };

    fileSystems."/home" = {
      device = "${disks.luksPrefix}${disks.rootUUID}";
      fsType = "btrfs";
      options = [
        "subvol=home"
      ];
    };

    fileSystems."/boot" = {
      device = "${disks.stdPrefix}${disks.bootUUID}";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [
      {
        device = "${disks.luksPrefix}${disks.swapUUID}";
      }
    ];
  };
}
