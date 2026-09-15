{ config, pkgs, ... }:

{
  # Required Packages
  environment.systemPackages = with pkgs; [
    fido2luks
    pam_u2f
  ];

  # Enable Trezor support. Handles udev rules and the Trezor Bridge subsystem
  services.trezord = {
    enable = true;
  };

  # Set up PAM for U2F
  security.pam = {
    u2f = {
      enable = true;
      control = "sufficient";
      settings = {
        authfile = "/etc/security/pam_u2f.conf";
        cue = true; # Visual cue when prompting
        #interactive = true; # Prompt user to connect U2F device before attempting scan
      };
    };
    services = {
      login = {
        u2fAuth = true;
      };
      sudo = {
        u2fAuth = true;
      };
    };
  };
}