{ inputs, lib, pkgs, config, ... }:

{
  environment.systemPackages = [
    #inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.ddcutil
  ];

  hardware = {
    bluetooth.enable = true;
    i2c.enable = true;
  };

  services = {
    power-profiles-daemon = {
      enable = true;
    };

    upower = {
      enable = true;
    };

    displayManager.noctalia-greeter = {
      enable = true;

      greeter-args = "";

      settings = {
        cursor = {
          theme = "Bibata-Modern";
          size = 24;
          path = "${pkgs.bibata-cursors}/share/icons";
        };
      };
    };

    gnome.gnome-keyring = {
      enable = lib.mkForce false;
    };
  };

  programs = {
    noctalia = {
      enable = true;
    };

    niri = {
      enable = true;
    };
  };
}
