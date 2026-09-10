{ inputs, lib, pkgs, config, ... }:

{
  /*
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  */

  hardware.bluetooth.enable = true;

  services = {
    power-profiles-daemon = {
      enable = true;
    };

    upower = {
      enable = true;
    };

    gnome.gnome-keyring = {
      enable = lib.mkForce false;
    };
  };

  programs = {
    noctalia = {
      enable = true;
    };

    noctalia-greeter = {
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
  

    niri = {
      enable = true;
    };
  };
}
