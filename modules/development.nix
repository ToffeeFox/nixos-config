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

    python = {
      homeManager = { pkgs, ... }: {
        home.packages = with pkgs; [
          python3
          # add more later
        ];
      };
    };

    rust = {
      homeManager = { pkgs, ... }: {
        home.packages = with pkgs; [
          rustc
          cargo
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
