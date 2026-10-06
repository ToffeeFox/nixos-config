{ den, flux, ... }: {
  flux.ssh.provides = {
    client.homeManager.services.ssh-agent.enable = true;

    server.nixos = {
      services.openssh = {
        enable = true;
        openFirewall = true;
      };
      users.users =
        let
          keys = [
            "pubkeys here after figuring out trezor nonsense"
          ];
        in
        {
          saluki.openssh.authorizedKeys = { inherit keys; };
          root.openssh.authorizedKeys = { inherit keys; };
        };
    };
  };
}
