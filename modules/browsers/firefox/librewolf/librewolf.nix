{ config, pkgs, lib, ... }:

let
  inherit (lib) mkForce;

  # This handy macro/lambda thing is great for force locking values in Firefox config
  lock-val = value: {
    Value = value;
    Status = "locked";
  };

  # Nice macro for github URLs
  githubRaw = owner: repo: branch: path:
    "https://raw.githubusercontent.com/${owner}/${repo}/${branch}/${path}";
in

{
  imports = [
    ../firefox-common.nix
  ];

  programs = {
    firefox = {
      enable = true;
      package = pkgs.librewolf;

      /* Apparently this is home-manager exclusive. Because of course it is
      profiles = {
        primary = {
          id = 0;
          name = "Default";
          isDefault = true;
        };

        paranoia = {
          id = 1;
          name = "Paranoia";
          isDefault = false;
          settings = {
            # Enable letterboxing
            "privacy.resistFingerprinting.letterboxing" = lock-val true;

            # WebGL
            "webgl.disabled" = true;

            # DNS
            "network.dns.disableIPv6" = lock-val true;
            "network.trr.mode" = lock-val 3; # Force DoH
            "network.trr.uri" = lock-val "https://dns.mullvad.net/dns-query";

          };
        };
      };
      */
    };
  };
  # Remap Firefox policies to Librewolf
  environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";
}
