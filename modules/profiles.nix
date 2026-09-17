{ den, __findFile, ... }:
{
  flux = {
    workstation.includes = [
      <flux/boot>
    ];

    laptop.includes = [
      <flux/boot/graphical>
      <flux/boot/secure>
      <flux/workstation>
    ];
  };
}
