{ __findFile, den, flux, }:
{
  flux.apps.browser.librewolf = {
    # librewolf-specific config here
    # probably mostly done via home-manager.
    # will also import things from firefox-common
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        #librewolf # probably not the right package but we'll fix later
      ];
    };
  };
}
