{ flux, ... }:
{
  flux.trezor = {
    nixos =
    { lib, ... }:
    {
      services.trezord = {
        enable = true;
      };
    };

    homeManager =
    { pkgs, lib, ... }:
    {
      home.packages = with pkgs; [
        trezor-suite
      ];
    };
  };
}
