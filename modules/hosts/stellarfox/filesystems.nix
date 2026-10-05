{ den, flux, ... }:
let
  disks = {
    luksPrefix = "/dev/mapper/luks-";
    stdPrefix = "/dev/disk/by-uuid/";

    bootUUID = "B288-F330";
    rootUUID = "983b1082-724b-4108-8226-f70d098dddcf";
    swapUUID = "5c9b5633-7943-4643-b7ca-769ce43444cd";
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
  den.aspects.stellarfox.nixos = {
    fileSystems = {
      "/" = {
        device = "${disks.luksPrefix}${disks.rootUUID}";
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
    // (btrfsSubvols disks.luksPrefix disks.rootUUID [
      "nix"
      "home"
    ]);

    boot.initrd.luks.devices = {
      "luks-${disks.rootUUID}" = {
        crypttabExtraOpts = [ "fido2-device=auto" ];
        device = "${disks.stdPrefix}${disks.rootUUID}";
      };

      "luks-${disks.swapUUID}" = {
        crypttabExtraOpts = [ "fido2-device=auto" ];
        device = "${disks.stdPrefix}${disks.swapUUID}";
      };
    };

    swapDevices = [
      { device = "${disks.luksPrefix}${disks.swapUUID}"; }
    ];
  };
}
