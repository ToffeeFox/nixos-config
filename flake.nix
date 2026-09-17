{
  description = "NixOS configuration with flakes";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";
    den.url = "github:denful/den";

    nixpkgs = {
      url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      # using niri from nixpkgs
      inputs.niri-unstable.follows = "";
      inputs.niri-stable.follows = "";
      inputs.xwayland-satellite-unstable.follows = "";
      inputs.xwayland-satellite-stable.follows = "";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.foxpad-ultranix = nixpkgs.lib.nixosSystem {

      modules = [

        # Import previous configuration.nix to prevent breakage during migration
        ./configuration.nix

        # NixOS Hardware Profile
        inputs.nixos-hardware.nixosModules.dell-precision-5570

        ## Noctalia and its Greeter
        inputs.noctalia.nixosModules.default
        inputs.noctalia-greeter.nixosModules.default
      ];
    };
  };
}
