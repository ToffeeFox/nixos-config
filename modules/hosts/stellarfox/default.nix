{ flux, inputs, ... }:
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
    includes = with flux; [

    ];

    nixos = {
      imports = [
          inputs.nixos-hardware.nixosModules.dell-precision-5570
        ];

        boot = {
          plymouth.enable = true;
        };

        networking.hostName = "stellarfox";
        networking.networkmanager.enable = true;

        services = {
          fprintd.enable = true; # Enable fingerprint scanner
          fwupd.enable = true; # Enable firmware updates with `fwupdmgr update`
        };
      };
  };
}
