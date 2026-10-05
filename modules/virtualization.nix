{ den, flux, ... }:
{
  flux.virt.provides = {
    qemu = {
      nixos = { pkgs, ... }: {
        boot.kernelParams = [ "amd_iommu=on" ];
        users.privilegedGroups = [ "kvm" ];
        networking.firewall.trustedInterfaces = [ "virbr0" ];
        programs.virt-manager.enable = true;
        environment.systemPackages = with pkgs; [
          virglrenderer
        ];
        services.qemuGuest.enable = true;
        virtualisation = {
          libvirtd.enable = true;
          spiceUSBRedirection.enable = true;
        };
      };
    };

    waydroid.nixos = {
      virtualization.waydroid = {
        enable = true;
      };
    };

    podman = {
      nixos = { pkgs, ... }: {
        network.firewall.trustedInterfaces = [ "podman0" ];
        users.privilegedGroups = [ "podman" ];
        virtualization.podman = {
          enable = true;
          autoPrune = {
            enable = true;
            flags = [ "--all" ];
          };
        };

        environment.systemPackages = with pkgs; [
          podman-tui
        ];
      };

      provides = {
        dockerCompat.nixos = { pkgs, ... }: {
          virtualization.podman = {
            dockerCompat = true;
            dockerSocket = {
              enable = true;
            };
          };

          environment.systemPackages = with pkgs; [
            #podman-compose # Not sure if this is required
          ];
        };
      };
    };
  };
}
