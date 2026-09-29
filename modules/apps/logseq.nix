{
  flux.apps._.logseq = {
    homeManager =
    { pkgs, ... }:
    let
      logseq-electron-patch = pkgs.logseq.override {
        electron_39 = pkgs.electron_42;
      };
    in
    {
      home.packages = [
        logseq-electron-patch
      ];
    };
  };
}
