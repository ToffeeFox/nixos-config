{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Secure Boot Manager Package Thing
    sbctl
  ];
}