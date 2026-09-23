{ __findFile, den, flux, ... }:
{
  flux.development = {
    provides.usb.nixos = {
      users.privilegedGroups = [ "plugdev" ];
    };

    provides.android = {
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

    provides.nix = {
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
