{
  flux.git = {
    nixos.programs.git.enable = true;

    homeManager = {
      programs.git = {
        enable = true;

        settings = {
          init = {
            defaultBranch = "main";
          };

          user = {
            name = "ToffeeFox";
            email = "dev@toffeefox.com";
          };
        };
      };
    };
  };
}
