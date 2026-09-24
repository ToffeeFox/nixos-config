{ __findFile, flux, inputs, ... }:
{
  den.hosts.x86_64-linux.stellarfox = {
    users.saluki.classes = [ "homeManager" ];
    displays = {
      eDP-1 = {
        refresh = 60.0;
        width = 1920;
        height = 1200;
        scaling = 1.20;
        wallpaper = /assets/background.png;
      };
    };
  };
  den.aspects.saluki = {
    includes = [
      <flux/laptop>
      <flux/security/fprint>
      <flux/security/u2f>
    ];

    nixos = { modulesPath, ... }: {
      imports = [
          #(modulesPath + "/installer/scan/not-detected.nix")
          inputs.nixos-hardware.nixosModules.dell-precision-5570
        ];

        hardware.enableRedistributableFirmware = true;

        #boot = {
        #  initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "rtsx_pci_sdmmc" ];
        #  kernelModules = [ "kvm-intel" ];
        #};

        hardware.bluetooth.enable = true;

        networking.hostName = "stellarfox";
        networking.networkmanager.enable = true;

        services = {
          fwupd.enable = true; # Enable firmware updates with `fwupdmgr update`
          power-profiles-daemon.enable = true;
          upower.enable = true;
        };
      };
  };
}
