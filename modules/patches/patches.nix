{
  flux.patches = {
    logseq = {
      homeManager._module.args.logseqPatches = [
        ./logseq-electron43.patch
      ];
    };

    trezorAgent = {
      # TODO: fill in later with trezor agent patches
      # Want to use 0.13.0 instead of 0.12.0
    };
  };
}
