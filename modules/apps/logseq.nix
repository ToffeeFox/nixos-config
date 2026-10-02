{ inputs, ... }:
let
  logseqPatch = builtins.toFile "logseq-electron43.patch" ''
    diff --git a/pkgs/by-name/lo/logseq/bump-better-sqlite3.patch b/pkgs/by-name/lo/logseq/bump-better-sqlite3.patch
    index 782e3c3ff214e..153318a05a339 100644
    --- a/pkgs/by-name/lo/logseq/bump-better-sqlite3.patch
    +++ b/pkgs/by-name/lo/logseq/bump-better-sqlite3.patch
    @@ -7,7 +7,7 @@ index de39ccc..d42b7fb 100644
          "@sentry/electron": "2.5.1",
          "abort-controller": "3.0.0",
     -    "better-sqlite3": "12.4.1",
    -+    "better-sqlite3": "12.8.0",
    ++    "better-sqlite3": "12.11.1",
          "chokidar": "^3.5.1",
          "command-exists": "1.2.9",
          "diff-match-patch": "1.0.5",
    @@ -47,10 +47,10 @@ index 36b4476..4738ef9 100644
     -  version "12.4.1"
     -  resolved "https://registry.yarnpkg.com/better-sqlite3/-/better-sqlite3-12.4.1.tgz#f78df6c80530d1a0b750b538033e6199b7d30d26"
     -  integrity sha512-3yVdyZhklTiNrtg+4WqHpJpFDd+WHTg2oM7UcR80GqL05AOV0xEJzc6qNvFYoEtE+hRp1n9MpN6/+4yhlGkDXQ==
    -+better-sqlite3@12.8.0:
    -+  version "12.8.0"
    -+  resolved "https://registry.yarnpkg.com/better-sqlite3/-/better-sqlite3-12.8.0.tgz#ec9ccd4a426a35f3b9355c147af6c92a6ddd6862"
    -+  integrity sha512-RxD2Vd96sQDjQr20kdP+F+dK/1OUNiVOl200vKBZY8u0vTwysfolF6Hq+3ZK2+h8My9YvZhHsF+RSGZW2VYrPQ==
    ++better-sqlite3@12.11.1:
    ++  version "12.11.1"
    ++  resolved "https://registry.yarnpkg.com/better-sqlite3/-/better-sqlite3-12.11.1.tgz#067846efabf7671957fc8a9e8df3be39c6cc0b84"
    ++  integrity sha512-dq9AtApgg5PGFtBzPFSBl3HZQjHok5gaQCM6zh2Yk0aSmDCs1CbnVI8/HgASQkNKsWFpseIO9beg5xxpYhbIfA==
        dependencies:
          bindings "^1.5.0"
          prebuild-install "^7.1.1"
    diff --git a/pkgs/by-name/lo/logseq/package.nix b/pkgs/by-name/lo/logseq/package.nix
    index 9eff3bf535eed..9fc646395d2ef 100644
    --- a/pkgs/by-name/lo/logseq/package.nix
    +++ b/pkgs/by-name/lo/logseq/package.nix
    @@ -21,12 +21,12 @@
       xcbuild,
       zip,
    ${" "}
    -  electron_39,
    +  electron_43,
       git,
     }:
    ${" "}
     let
    -  electron = electron_39;
    +  electron = electron_43;
     in
     stdenv.mkDerivation (finalAttrs: {
       pname = "logseq";
    @@ -118,7 +118,7 @@ stdenv.mkDerivation (finalAttrs: {
         name = "logseq-''${finalAttrs.version}-yarn-deps-static-resources";
         inherit (finalAttrs) src patches;
         postPatch = "cd ./static";
    -    hash = "sha256-TFisR5GwcKmuddGhe0i6rAmr2wDWzed/mXnxVGARYK0=";
    +    hash = "sha256-jF3mGuLYL2NZ96w+tPRgB77pfdnviKF/s63TuiHOyfQ=";
       };
    ${" "}
       yarnOfflineCacheAmplify = fetchYarnDeps {
  '';
in
{
  flux.apps._.patched_logseq = {
    homeManager =
      { pkgs, ... }:
      let
        system = pkgs.stdenv.hostPlatform.system;
        patchedNixpkgs = inputs.nixpkgs-patcher.lib.patchNixpkgs {
          inherit system inputs;
          nixpkgs = inputs.nixpkgs;
          patches = [ logseqPatch ];
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
