{ inputs, ... }:
{
  flux.apps._.patched_logseq = {
    homeManager =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      patchedNixpkgs = inputs.nixpkgs-patcher.lib.patchNixpkgs {
        inherit system inputs;
        nixpkgs = inputs.nixpkgs;
      };
      patchedPkgs = import patchedNixpkgs {
        inherit system;
        config = pkgs.config;
      };
    in
    {
      home.packages = [
        patchedPkgs.logseq
      ];
    };
  };
}
