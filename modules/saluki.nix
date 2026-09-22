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
      <flux/apps/zen>
      <flux/apps/browser/brave>
    ];
  };
}
