{ __findFile, den, ... }:
{
  den.aspects.saluki = {
    includes = [
      <den/primary-user>
      <flux/batteries/privileged-user>
      <flux/niri>
      <flux/xdg>
      <flux/zsh>
      <flux/shell/terminal>
      <flux/development/android>
      <flux/development/nix>

      <flux/peripherals/logitech>
      <flux/trezor>

      <flux/apps/git>
      <flux/apps/keepassxc>
      #<flux/apps/patched_logseq>
      <flux/apps/zed-editor>
      <flux/apps/browser/brave>
      <flux/apps/browser/zen>
    ];

    nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # System utilities
        inetutils
        pciutils
        kdePackages.filelight
        kdePackages.kate
        kdePackages.partitionmanager

        # Misc. Productivity
        libreoffice-stable
        hunspell
        hunspellDicts.en_US-large
        hunspellDicts.es_ES # Castillian Spanish
        hunspellDicts.es_MX # Mexican Spanish
      ];
    };

    homeManager =
    { pkgs, config, ... }:
    {
      gtk = {
        enable = true;
        gtk4.theme = config.gtk.theme;
        iconTheme = {
          name = "Fluent-Dark";
          package = pkgs.fluent-icon-theme;
        };
      };
      home.pointerCursor = {
        enable = true;
        package = pkgs.posy-cursors;
        name = "Posy_Cursor";
        gtk.enable = true;
      };

      programs.git.settings = {
        user.name = "ToffeeFox";
        user.email = "dev@toffeefox.com";
      };

      programs.gh.enable = true;

      home.packages = with pkgs; [
        # Utilities
        boatswain
        filezilla
        popsicle

        # Media
        finamp

        ## Communications
        telegram-desktop
        thunderbird
      ];
    };
  };
}
