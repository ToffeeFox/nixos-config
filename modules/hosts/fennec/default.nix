{ __findFile, flux, inputs, ... }:
{
  den.hosts.x86_64-linux.fennec = {
    users.saluki.classes = [ "homeManager" ];

    displays = {
      /*
      eDP-1 = {
        refresh = 60.0;
        width = 1920;
        height = 1200;
        scaling = 1.20;
        wallpaper = /assets/background.png;
      };
      */
    };
  };
  den.aspects.fennec = {
    includes = [
      <flux/minipc>
      <flux/security/u2f>
    ];

    nixos = { ... }: {
      imports = [
          #TODO: AMD mini PC generics from nixos-hardware
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-ssd
        ];

        hardware.enableRedistributableFirmware = true;

        boot = {
          initrd.availableKernelModules = [
            "nvme"
            "xhci_pci"
            "ahci"
            "thunderbolt"
            "usbhid"
            "usb-storage"
          ];
          kernelModules = [ "kvm-amd" ];
        };

        hardware.bluetooth.enable = true;

        networking.hostName = "fennec";
        networking.networkmanager.enable = true;

        services = {
          fwupd.enable = true; # Enable firmware updates with `fwupdmgr update`
          power-profiles-daemon.enable = true;
          upower.enable = true;
        };
      };
  };
}
