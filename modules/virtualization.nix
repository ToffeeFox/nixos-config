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

    podman.nixos = {
      network.firewall.trustedInterfaces = [ "podman0" ];
      users.privilegedGroups = [ "podman" ];
      virtualization.podman = {
        enable = true;

        autoPrune = {
          enable = true;
          flags = [ "--all" ];
        };

        dockerCompat = true;
        dockerSocket = {
          enable = true;
        };
      };
    };
  };
}
