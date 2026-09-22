{ __findFile, ... }:
{
  den.aspects.saluki = {
    includes = [
      <den/primary_user>
      <flux/niri>
      <flux/xdg>
      <flux/zsh>

      <flux/apps/git>
      <flux/apps/patched_logseq>
      <flux/apps/zed-editor>
      <flux/apps/browser/brave>
      <flux/apps/browser/zen>
    ];

    homeManager =
    { config, pkgs, ... }:
    {
      programs.git.settings = {
        user.name = "ToffeeFox";
        user.email = "dev@toffeefox.com";
      };

      home.packages = with pkgs; [
        finamp
      ];
    };
  };
}
