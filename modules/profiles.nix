{ den, __findFile, ... }:
{
  flux = {
    workstation.includes = [
      <flux/boot>
      <flux/virt/podman>
      <flux/virt/podman/dockerCompat>
    ];

    headless.includes = [
      <flux/cockpit>
      <flux/ssh/server>
    ];

    laptop.includes = [
      <flux/boot/graphical>
      <flux/boot/secure>
      <flux/workstation>
      <flux/homelab/access>
    ];

    minipc.includes = [
      <flux/boot/secure>
      <flux/boot/graphical>
      <flux/workstation>
      <flux/headless>
    ];
  };
}
