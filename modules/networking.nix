{
  flux.networking = {
    # default
    nixos = { pkgs, ... }: {
      #services.resolved.settings.Resolve.ResolveUnicastSingleLabel = true;
      #systemd.network.networks."40-eth0".networkConfig.UseDomains = "yes";
    };

    provides = {
      static = {
        nixos.networking.tempAddresses = "disabled";
      };

      wol = {
        nixos.systemd.network.links."10-wol" = {
          matchConfig.type = "ether";
          linkConfig.WakeOnLan = "magic";
        };
      };

      wireless = {
        nixos = { lib, ... }: {
          systemd.network.enable = lib.mkForce false;
          networking.networkmanager.enable = true;
          services.resolved.enable = true;
        };
      };
    };
  };
}
