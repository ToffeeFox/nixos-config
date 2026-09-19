{
  flux.apps._.patched_logseq = {
    homeManager =
    { pkgs, ... }:
    let
      logseq-electron-patch = pkgs.logseq.override {
        electron_27 = pkgs.electron_34;
      };
    in
    {
      home.packages = [
        logseq-electron-patch
      ];
    };
  };
}
