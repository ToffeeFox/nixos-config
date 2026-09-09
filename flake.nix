{
  description = "NixOS configuration with flakes";

  inputs = {

    nixpkgs = {
      url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    };

    nixos-hardware = {
      url= "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
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

  outputs = inputs@{ self, nixpkgs, nixos-hardware, ... }: {
    nixosConfigurations.foxpad-ultranix = nixpkgs.lib.nixosSystem {

      modules = [

        # Import previous configuration.nix to prevent breakage during migration
        ./configuration.nix

        # NixOS Hardware Profile
        nixos-hardware.nixosModules.dell-precision-5570

        # Niri
        ## Core Settings
        ./niri.nix

        ## Noctalia and its Greeter
        inputs.noctalia.nixosModules.default
        inputs.noctalia-greeter.nixosModules.default
      ];
    };

  };
}
