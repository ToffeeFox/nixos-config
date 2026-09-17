{ ... }:
{
  flux.apps._.zed-editor.homeManager = {
    programs.zed-editor = {
      enable = true;

      extensions = [
        "comment"
        "csv"
        "git-firefly"
        "html"
        "java"
        "just"
        "kdl"
        "log"
        "nix"
        "toml"
        "xml"
      ];
    };
  };
}
