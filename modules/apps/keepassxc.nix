{
  flux.apps._.keepassxc = {
    homeManager =
    { lib, ... }:
    {
      programs.keepassxc = {
        enable = true;
        autostart = true;

        settings = {
          # Prevent error messages related to browser integration installation failure
          # programs.keepass.xc.enable handles browser integration installs automatically
          Browser.UpdateBinaryPath = false;

          GUI = {
            AdvancedSettings = true;
            ApplicationTheme = "dark";

            ColorPasswords = lib.mkDefault true;

            ShowTrayIcon = true;
          };

          PasswordGenerator = {
            WordSeparator = "-";
          };

          Security = {
            ClearClipboard = lib.mkForce true;
            ClearClipboardTimeout = lib.mkForce 10;

            LockDatabaseIdle = lib.mkForce true;
            LockDatabaseIdleSeconds = lib.mkForce 900;

            LockDatabaseMinimize = false; # I'm chill with this one being fucked with tbh
            LockDatabaseScreenLock = lib.mkForce true;
            LockDatabaseOnUserSwitch = lib.mkForce true;
          };

          # Use KeePassXC for Secret Service
          FdoSecrets = {
            Enabled = true;

            ShowNotification = lib.mkForce true;

            ConfirmAccessItem = lib.mkForce true;
            ConfirmDeleteItem = lib.mkForce true;

            UnlockBeforeSearch = lib.mkForce true;
          };
        };
      };

      xdg.autostart.enable = true;
    };
  };
}
