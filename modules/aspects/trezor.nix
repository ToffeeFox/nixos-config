{ flux, ... }:
{
  flux.trezor = {
    nixos =
    { lib, ... }:
    {
      # handles udev rules and the trezor daemon
      services.trezord = {
        enable = true;
      };
    };

    homeManager =
    { pkgs, lib, ... }:
    {
      home.packages = with pkgs; [
        trezor-suite
        # considering eventually moving to my own flake for the
        # trezor-suite package because the upstream is not always up to date

        #trezor-agent
      ];
    };
  };
}
