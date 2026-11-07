{ den, flux, ... }:
{
  flux.homelab.provides = {
    access = {
      nixos = { ... }: {
        # CF Warp
        services.cloudflare-warp = {
          enable = true;
        };

        # Netbird
        users.privilegedGroups = [ "netbird-wt0" ];
        services.netbird = {
          #enable = true;

          clients.wt0 = {
            port = 51821;
            openFirewall = true;
            openInternalFirewall = true;

            ui.enable = true;
          };
        };
      };
    };
  };
}
