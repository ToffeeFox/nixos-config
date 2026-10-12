{ den, flux, lib, ... }:
let
  # Using mkOverride w/ val 64 here is enough to override options
  # as set by other modules, because by default, regular option definitions
  # have priority 100.
  # However, mkForce has a default priority of 50, so it can still override
  # anything set with softForce.
  #
  # Now, did writing all of this comment text take wayyyyy longer than just using
  # mkOverride directly?
  #
  # I mean. Yeah.
  #
  # But at least if I take a break and come back to this I'll understand
  # what I was doing
  # Also this is my personal config, so I do what I want :3
  softForce = value: lib.mkOverride 64 value;
in
{
  flux.ssh.provides = {
    client.homeManager.services.ssh-agent = {
      enable = true;
    };

    server.nixos = {
      services.openssh = {
        enable = true;
        openFirewall = true;
        settings = {
          # softForcing this to true so we can still use password auth
          # until we fully migrate to key-based auth
          PasswordAuthentication = softForce true;
        };
      };
      users.users =
        let
          keys = [
            "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAILRX/GCHT+QS71rYUMQz6IYb+asMpWZ/1PDfIcTirRXJAAAABHNzaDo= saluki@foxlab"
            # Add spare/backup/emergency key (first figure out how we're implementing this)
          ];
        in
        {
          saluki.openssh.authorizedKeys = { inherit keys; };
          root.openssh.authorizedKeys = { inherit keys; };
        };
    };
  };
}
