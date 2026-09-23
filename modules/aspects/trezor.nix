{
  flux._.trezor = {
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
      home.packahes = with pkgs; [
        trezor-suite
      ];
    };
  };
}
