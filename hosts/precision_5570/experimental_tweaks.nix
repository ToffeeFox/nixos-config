{ config, pkgs, lib, ... }:

{
  hardware.cpu.intel = {
    updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  hardware.graphics.enable = true;

  hardware.intelgpu = {
    vaapiDriver = "intel-media-driver";
    driver = lib.mkIf (lib.versionAtLeast config.boot.kernelPackages.kernel.version "6.8") "xe";
  };

  boot.kernelParams = lib.mkIf (config.hardware.intelgpu.driver == "xe") [
    "i915.force_probe=!46a6"
    "xe.force_probe=46a6"
  ];

  # Set up NVIDIA PRIME dual mobile GPU
  hardware.nvidia = {
    nvidiaSettings = lib.mkDefault true;
    modesetting.enable = lib.mkDefault true; # Needed for Wayland
    open = false; # Use the open-source NVIDIA Drivers

    prime = {
    #offload.enable = true;

      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };

  # Override Intel GPU driver settings imported above (not sure why but okay)
  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.graphics.enable (lib.mkOverride 990 "nvidia");
  };

  # Set up xserver w/ NVIDIA/Intel dual gpu
  services.xserver = {
    enable = true;
    videoDrivers = [
      "modesetting"
      "nvidia"
    ];
  };

  services.thermald = {
    enable = lib.mkDefault true;
  };

  # Set up fingerprint auth
  services.fprintd = {
    enable = true;
    #package = pkgs.fprintd-tod;
    #tod = {
    #  enable = true;
    #  driver = pkgs.libfprint-2-tod1-goodix;
    #};
  };

  security.pam.services.login.fprintAuth = false;
}
