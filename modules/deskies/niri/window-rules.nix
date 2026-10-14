{
  # niri applies window rules in order, so later rules override earlier ones.
  # Find a window's app-id with `niri msg pick-window`.
  flux.deskies.niri._.window-rules.homeManager = {
    programs.niri.settings.window-rules = [
      # Global
      {
        draw-border-with-background = false;

        background-effect = {
          blur = true;
          xray = false;
        };

        geometry-corner-radius = {
          top-left = 8.0;
          top-right = 8.0;
          bottom-left = 8.0;
          bottom-right = 8.0;
        };

        clip-to-geometry = true;
      }

      # Per-program window rules

      ## Alacritty
      {
        matches = [ { app-id = "^[Aa]lacritty$"; } ];
        default-column-width.proportion = 0.5;
      }

      ## Zed Editor
      {
        matches = [ { app-id = "^dev\\.zed\\.Zed$"; } ];
        default-column-width.proportion = 0.9;
      }

      ## Zen Browser
      {
        matches = [ { app-id = "^zen-(beta|browser)$"; } ];
        default-column-width.proportion = 0.9;
      }
    ];
  };
}
