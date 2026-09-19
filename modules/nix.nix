{ inputs, ... }:
{
  den.default = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.nix-index-database.nixosModules.nix-index ];
        nixpkgs.config.allowUnfree = true;
        programs.nix-index-database.comma.enable = true;
        programs.nix-ld.enable = true;
        programs.command-not-found.enable = false;

        nix = {
          package = pkgs.nixVersions.latest;
          optimise.automatic = false;
          registry.nixpkgs.flake = inputs.nixpkgs;
          gc.automatic = true;
          settings = {
            experimental-features = [
              "nix-command"
              "flakes"
            ];
            trusted-users = [
              "@wheel"
            ];
            keep-outputs = true;
            keep-derivations = true;
            use-xdg-base-directories = true;
            auto-optimise-store = true;
          };
        };
      };
  };
}
