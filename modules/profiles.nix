{ den, __findFile, ... }:
{
  flux = {
    workstation.includes = [
      <flux/boot>
      <flux/virt/podman>
      <flux/virt/podman/dockerCompat>
    ];

    headless = {
      includes = [
        <flux/cockpit>
        <flux/ssh/server>
      ];

      # Never sleep at the OS level, so it also applies with no one logged in
      # (e.g. at the LightDM greeter), not just inside a desktop session.
      nixos = {
        # logind reports CanSuspend/CanHibernate = "na", so greeters and
        # desktops hide sleep actions, and requests are refused.
        systemd.sleep.settings.Sleep = {
          AllowSuspend = "no";
          AllowHibernation = "no";
          AllowHybridSleep = "no";
          AllowSuspendThenHibernate = "no";
        };

        # Mask the targets so nothing can start them directly.
        systemd.targets = {
          sleep.enable = false;
          suspend.enable = false;
          hibernate.enable = false;
          hybrid-sleep.enable = false;
          suspend-then-hibernate.enable = false;
        };

        services.logind.settings.Login = {
          HandleSuspendKey = "ignore";
          HandleSuspendKeyLongPress = "ignore";
          HandleHibernateKey = "ignore";
          HandleHibernateKeyLongPress = "ignore";
          HandleLidSwitch = "ignore";
          HandleLidSwitchExternalPower = "ignore";
          HandleLidSwitchDocked = "ignore";
          IdleAction = "ignore";
        };
      };
    };

    laptop.includes = [
      <flux/boot/graphical>
      <flux/boot/secure>
      <flux/workstation>
      <flux/homelab/access>
    ];

    minipc.includes = [
      <flux/boot/secure>
      <flux/boot/graphical>
      <flux/workstation>
      <flux/headless>
    ];
  };
}
