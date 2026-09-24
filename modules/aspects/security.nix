{ den, flux, ... }:
{
  flux.security.provides = {
    fprint = {
      nixos = { config, ... }:
      {
        services.fprintd.enable = true;

        security.pam.services = {
          login = {
            fprintAuth = config.services.fprintd.enable;
          };

          sudo = {
            fprintAuth = config.services.fprintd.enable;
          };
        };
      };
    };

    u2f = {
      nixos = { pkgs, ... }:
      {
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

        environment.systemPackages = with pkgs; [
          pam_u2f
        ];
      };
    };
  };
}
