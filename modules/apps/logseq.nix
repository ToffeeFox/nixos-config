{
  flux.apps._.patched_logseq = {
    homeManager =
    { pkgs, ... }:
    let
      electron43Patch = builtins.toFile "better-sqlite3-electron-43.patch" (
        builtins.concatStringsSep "\n" [
          "diff --git a/src/better_sqlite3.cpp b/src/better_sqlite3.cpp"
          "--- a/src/better_sqlite3.cpp"
          "+++ b/src/better_sqlite3.cpp"
          "@@ -57,6 +57,6 @@ NODE_MODULE_INIT(/* exports, context */) {"
          " \t// Initialize addon instance."
          " \tAddon* addon = new Addon(isolate);"
          "-\tv8::Local<v8::External> data = v8::External::New(isolate, addon);"
          "+\tv8::Local<v8::External> data = EXTERNAL_NEW(isolate, addon);"
          " \tnode::AddEnvironmentCleanupHook(isolate, Addon::Cleanup, addon);"
          " "
          " \t// Create and export native-backed classes and functions."
          "diff --git a/src/util/helpers.cpp b/src/util/helpers.cpp"
          "--- a/src/util/helpers.cpp"
          "+++ b/src/util/helpers.cpp"
          "@@ -89,7 +89,7 @@ void SetPrototypeGetter("
          " \trecv->InstanceTemplate()->SetNativeDataProperty("
          " \t\tInternalizedFromLatin1(isolate, name),"
          " \t\tfunc,"
          "-\t\t0,"
          "+\t\tnullptr,"
          " \t\tdata"
          " \t);"
          " }"
          "diff --git a/src/util/macros.cpp b/src/util/macros.cpp"
          "--- a/src/util/macros.cpp"
          "+++ b/src/util/macros.cpp"
          "@@ -27,7 +27,14 @@"
          " #define EasyIsolate v8::Isolate* isolate = v8::Isolate::GetCurrent()"
          " #define OnlyIsolate info.GetIsolate()"
          " #define OnlyContext isolate->GetCurrentContext()"
          "-#define OnlyAddon static_cast<Addon*>(info.Data().As<v8::External>()->Value())"
          "+#if defined(NODE_MODULE_VERSION) && NODE_MODULE_VERSION >= 146"
          "+#define EXTERNAL_NEW(isolate, value) v8::External::New((isolate), (value), 0)"
          "+#define EXTERNAL_VALUE(value) (value)->Value(0)"
          "+#else"
          "+#define EXTERNAL_NEW(isolate, value) v8::External::New((isolate), (value))"
          "+#define EXTERNAL_VALUE(value) (value)->Value()"
          "+#endif"
          "+#define OnlyAddon static_cast<Addon*>(EXTERNAL_VALUE(info.Data().As<v8::External>()))"
          " #define UseIsolate v8::Isolate* isolate = OnlyIsolate"
          " #define UseContext v8::Local<v8::Context> ctx = OnlyContext"
          " #define UseAddon Addon* addon = OnlyAddon"
        ] + "\n"
      );
      logseq-electron-patch = (pkgs.logseq.override {
        electron_39 = pkgs.electron_43;
      }).overrideAttrs (old: {
        # Logseq pins better-sqlite3 12.8.0, which needs this fix for Electron 42's V8 API.
        # We must patch it inside the 'static' directory before the npm rebuild runs.
        postConfigure = builtins.replaceStrings
          [ "# the electron-rebuild command deadlocks for some reason, let's just use normal npm rebuild (since we overrode the nodedir anyways)\nnpm rebuild --verbose" ]
          [ "# the electron-rebuild command deadlocks for some reason, let's just use normal npm rebuild (since we overrode the nodedir anyways)\npatch -d node_modules/better-sqlite3 -p1 < ${electron43Patch}\nnpm rebuild --verbose" ]
          old.postConfigure;
      });
    in
    {
      home.packages = [
        logseq-electron-patch
      ];
    };
  };
}
