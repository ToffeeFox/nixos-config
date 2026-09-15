{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/security/fprint.nix
  ];
}
