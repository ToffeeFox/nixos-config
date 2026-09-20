let
  local_ai = {
    host = "192.168.1.224";
    port = "11434";

    curated_models = {
      code_assistant = "gemma4:26b";
      code_predictions = "qwen2.5-coder:7b-base";
    };
  };
in
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

      userSettings = { # to be written to zed-editor's `settings.json`
        language_models = {
          ollama = {
            api_url = "http://${local_ai.host}:${local_ai.port}";
          };
        };

        agent = {
          sidebar_side = "right";

          default_model = {
            provider = "ollama";
            model = "gemma4:26b";
            enable_thinking = "true";
          };

          favorite_models = [];

          model_parameters = [];
        };

        edit_predictions = {
          provider = "ollama";

          ollama = {
            api_url = "http://192.168.1.224:11434";
            model = "qwen2.5-coder:7b-base";
          };
        };

        tab_bar = {
          show_pinned_tabs_in_separate_row = true;
        };

        tabs = {
          file_icons = true;
          git_status = true;
        };

        title_bar = {
          show_menus = false;
          show_branch_status_icon = true;
        };

        status_bar = {
          show_active_file = true;
        };


      };
    };
  };
}
