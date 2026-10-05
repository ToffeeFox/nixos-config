{ den, flux, ... }:
{
  flux.cockpit = {
    includes = [
      (den.lib.policy.when
        ({ hasAspect, ... }: hasAspect flux.virt.podman)
        {
          nixos = { pkgs, ... }: {
            services.cockpit.plugins = with pkgs; [
              cockpit-podman
            ];
          };
        })
    ];

    nixos = { pkgs, ... }: {
      services.cockpit = {
        enable = true;
        plugins = with pkgs; [
          cockpit-files
        ];
      };
    };
  };
}
