{ inputs, den, flux, ... }:
{
  flux.apps.browser.zen = {
    set-default = {
      includes = [
        # Only claim default-browser MIME handlers when xdg (and thus mimeapps.list) is managed
        (den.lib.policy.when
          ({ hasAspect, ... }: hasAspect flux.xdg)
          {
            homeManager.programs.zen-browser.setAsDefaultBrowser = true;
          })
      ];

      # This should function even in environments where xdg/MIME handlers are not managed
      homeManager.home.sessionVariables.BROWSER = "zen-beta";
    };

    homeManager = { config, ... }: {
      imports = [ inputs.zen-browser.homeModules.default ];

      programs.zen-browser.enable = true;

      # TODO: preconfigure extensions
    };
  };
}
