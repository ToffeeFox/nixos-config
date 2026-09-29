{
  flux.apps.browser.brave = {
    homeManager = {
      programs.brave = {
        enable = true;

        #TODO: preconfigure general settings
        # homepageLocation = "https://www.startpage.com/";

        #TODO: preconfigure content blocking policies
        # Yes the below is pseudocode, I'll fix it later
        # settings.contentBlocker.useExternalLists = [ github:toffeefox/adfilt ];

        #TODO: preconfigure extensions

        commandLineArgs = [
          ""
        ];
      };
    };
  };
}
