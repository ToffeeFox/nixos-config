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

    docker.nixos = {
      networking.firewall.trustedInterfaces = [ "docker0" ];
      users.privilegedGroups = [ "docker" ];
      virtualization.docker.enable = true;
    };

    podman.nixos = {
      network.firewall.trustedInterfaces = [ "podman0" ];
      virtualization.podman = {
        enable = true;
        autoPrune = {
          enable = true;
          flags = [ "--all" ];
        };
      };
    };
  };
}
