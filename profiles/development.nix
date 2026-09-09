# This profile includes everything I need for programming
{ config, pkgs, ...  }:

{
  users.users.saluki.extraGroups = [
    "dialout"
    "plugdev"
  ];

  environment.systemPackages = with pkgs; [
    # Android
    android-tools

    # Arduino
    arduino-ide

    # Python
    (python313.withPackages (
      subpkgs: with subpkgs; [
        requests
        trezor # aka trezorctl, but we're doing it as a subpackage here for... reasons
      ]
    ))
    jupyter

    nil # Nix language server

    vscodium-fhs #FHS-compliant vscodium package, allowing for use of extensions without extra nix overrides
  ];
}
