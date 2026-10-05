{ den, flux, ... }:
let
  disks = {
    luksPrefix = "/dev/mapper/luks-";
    stdPrefix = "/dev/disk/by-uuid/";

    bootUUID = "0DCA-2AFE";
    rootUUID = "4aa0548d-b56e-4da8-8552-3956a0389543";
    swapUUID = "919fb6e4-5a92-404d-ad76-f635e922fd63";
  };

  btrfsSubvols = diskType: diskUUID: subvols:
    builtins.listToAttrs (map (subvolLabel: {
      name = "/${subvolLabel}";
      value = {
        device = "${diskType}${diskUUID}";
        fsType = "btrfs";
        options = [ "subvol=${subvolLabel}" ];
      };
    }) subvols);
in
{
  den.aspects.fennec.nixos = {
    fileSystems = {
      "/" = {
        device = "${disks.stdPrefix}${disks.rootUUID}";
        fsType = "btrfs";
      };

      "/boot" = {
        device = "${disks.stdPrefix}${disks.bootUUID}";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };
    }
    // (btrfsSubvols disks.stdPrefix disks.rootUUID [
      "nix"
      "home"
    ]);

    /*
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
    */

    swapDevices = [
      {
        device = "${disks.stdPrefix}${disks.swapUUID}";
      }
    ];
  };
}
