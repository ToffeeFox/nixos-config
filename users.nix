{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  # Configure Home Manager
  ## Install packages to /etc/profiles
  home-manager.useUserPackages = true;
  ## Use the global pkgs instance
  home-manager.useGlobalPkgs = true;

  home-manager.users.saluki = {
    home.packages = with pkgs; [
      filezilla
      localsend
      syncthing
      syncthingtray
      telegram-desktop
      thunderbird
      trezor-suite
    ];

    # The state version is required and should stay at the version
    # you originally installed
    home.stateVersion = "26.05";
  };
}
