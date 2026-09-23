{ __findFile, den, flux, ... }:
{
  flux.development.provides = {
    usb.nixos = {
      users.privilegedGroups = [ "plugdev" ];
    };

    android = {
      includes = [
        <flux/development/usb>
      ];
      nixos =
        { lib, pkgs, ... }:
        {
          environment.systemPackages = with pkgs; [
            android-tools
          ];
        };
    };

    nix = {
      nixos =
        { lib, pkgs, ... }:
        {
          environment.systemPackages = with pkgs; [
            nil
            nixd
            nixfmt
          ];
        };
    };
  };
}
