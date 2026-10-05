{ den, __findFile, ... }:
{
  flux = {
    workstation.includes = [
      <flux/boot>
      <flux/virt/podman>
    ];

    laptop.includes = [
      <flux/boot/graphical>
      <flux/boot/secure>
      <flux/workstation>
      <flux/homelab/access>
    ];

    minipc.includes = [
      <flux/workstation>
    ];
  };
}
