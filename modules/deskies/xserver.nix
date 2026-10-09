{
  flux.xserver._.base = { host, ... }:
  {
    nixos = { pkgs, lib, ... }:
    {
      services.xserver = {
        enable = true;
      };
    };
  };
}
