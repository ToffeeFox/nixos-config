{ flux, inputs, ... }:
{
  flux.apps._.patched_logseq = {
    includes = [ flux.patches.logseq ];

    homeManager =
      { pkgs, logseqPatches, ... }:
      let
        system = pkgs.stdenv.hostPlatform.system;
        patchedNixpkgs = inputs.nixpkgs-patcher.lib.patchNixpkgs {
          inherit system inputs;
          nixpkgs = inputs.nixpkgs;
          patches = logseqPatches;
        };
        patchedPkgs = import patchedNixpkgs {
          inherit system;
          config = pkgs.config;
        };
      in
      {
        home.packages = [ patchedPkgs.logseq ];
      };
  };
}
