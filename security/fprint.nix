{ config, pkgs, lib, ... }:

{
  # Set up fingerprint auth
  services.fprintd = {
    enable = true;
    #package = pkgs.fprintd-tod;
    #tod = {
    #  enable = true;
    #  driver = pkgs.libfprint-2-tod1-goodix;
    #};
  };

  # This is weirdly necessary to prevent excessive delay during initial login via SDDM
  security.pam.services.login.fprintAuth = false;
}