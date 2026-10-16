{ lib, ... }:
{
  flux.apps._.keepassxc = {
    nixos.services.gnome.gnome-keyring.enable = lib.mkForce false;

    homeManager =
    { lib, config, ... }:
    {
      programs.keepassxc = {
        enable = true;
        # Started by the systemd user service below instead, so it can be
        # ordered after the SSH agent.
        autostart = false;

        settings = {
          # Prevent error messages related to browser integration installation failure
          # programs.keepassxc.enable handles browser integration installs automatically
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

          SSHAgent = {
            Enabled = true;

            UseOpenSSH = true;
            UsePageant = false;
          };
        };
      };

      systemd.user.services.keepassxc =
        let
          # Whatever unit provides $SSH_AUTH_SOCK (ssh-agent.service here).
          # set-SSH_AUTH_SOCK is ordered before it, so KeePassXC inherits the var.
          agentUnits = lib.optional config.sshAuthSock.enable config.sshAuthSock.systemd.socketProviderUnit;
        in
        {
          Unit = {
            Description = "KeePassXC password manager";
            PartOf = [ "graphical-session.target" ];
            # tray.target: wait for the system tray, or the tray icon is never created.
            After = [ "graphical-session.target" "tray.target" ] ++ agentUnits;
            Wants = [ "tray.target" ] ++ agentUnits;
          };
          Service = {
            ExecStart = lib.getExe' config.programs.keepassxc.package "keepassxc";
            Restart = "on-failure";
            Slice = "app.slice";
          };
          Install.WantedBy = [ "graphical-session.target" ];
        };
    };
  };
}
