{ __findFile, ... }:
{
  den.aspects.saluki = {
    includes = [
      <den/primary_user>
      <flux/niri>
      <flux/xdg>
      <flux/zsh>

      <flux/apps/patched_logseq>
      <flux/apps/zed-editor>
      <flux/apps/browser/zen>
      <flux/apps/browser/brave>
    ];

    homeManager =
    { config, ... }:
    {
      programs.git.settings = {
        user.name = "ToffeeFox";
        user.email = "dev@toffeefox.com";
      };
    };
  };
}
