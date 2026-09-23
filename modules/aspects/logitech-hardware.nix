{
  flux.peripherals._.logitech = {
    nixos =
    { ... }:
    {
      hardware.logitech.wireless.enable = true;

      programs.solaar = {
        enable = true;

        userService = {
          enable = true;

          batteryIcons = "symbolic";
        };
      };
    };

    homeManager =
    { lib, pkgs, ... }:
    {
      # nothing here for now
    };
  };
}
