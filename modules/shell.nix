{
  flux.shell = {
    provides.terminal = {
      nixos =
      { lib, pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          alacritty
        ];
      };
    };
    nixos =
      { lib, pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          btop
          bubblewrap
          tmux
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        home.shellAliases = {
          # Quick Utils
          ll = "ls -l";
          la = "ls -A";

          # System Mgmt
          hm = "home-manager";
          nixup = "sudo nixos-rebuild switch";
          homeup = "home-manager switch -b backup";
          flakeup = "nix flake update";
          flakecheck = "nix flake check --verbose --show-trace";
          sysflake-sync = "sudo rm -r /etc/nixos/* && sudo cp -r ~/nixos-config/* /etc/nixos/";
        };

        programs = {
          atuin = {
            enable = true;

            daemon.enable = true;

            settings = {
              search_mode = "fuzzy";
            };

            # In case Atuin decides it is too good for our nix config
            forceOverwriteSettings = true;
          };
        };

        home.packages = with pkgs; [
          fastfetch
        ];
      };
  };
}
