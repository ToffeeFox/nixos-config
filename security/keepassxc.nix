{ config, pkgs, lib, ... }:

{
  # Forcibly disable the Gnome Keyring if using KeePassXC
  services.gnome.gnome-keyring.enable = lib.mkForce false;

  programs.keepassxc = {
    enable = true;
    autostart = true;

    settings = {
      FdoSecrets.Enabled = true;
    };
  };

  xdg.autostart.enable = true;
}