{ inputs, ... }:
{
  flux.apps.browser.zen = {
    homeManager = { config, ... }: {
      imports = [ inputs.zen-browser.homeModules.default ];

      programs.zen-browser.enable = true;

      home.sessionVariables.BROWSER = "zen-beta";
    };
  };
}
