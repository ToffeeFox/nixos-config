{
  flux,
  inputs,
  lib,
  niri-lib,
  den,
  ...
}:
{
  flux.niri = {
    includes = [
      flux.wayland._.base
      flux.niri._.noctalia
      den.lib.perHost
      (
        { host, ... }:
        {
          homeManager =
            { pkgs, config, ... }:
            {
              programs.niri.settings.outputs = lib.mapAttrs (
                _: v: with v; {
                  mode = { inherit width height refresh; };
                  scale = scaling;
                  position = { inherit x y; };
                  variable-refresh-rate = lib.mkIf vrr "on-demand";
                  focus-at-startup = lib.mkIf primary true;
                }
              ) host.displays;
            };
        }
      )
    ];

    nixos =
      { config, pkgs, ... }:
      {
        environment = {
          # Apparently these are needed to fix java gui apps idk man
          variables.AWT_TOOLKIT = "MToolkit";
          variables._JAVA_AWT_WM_NONREPARENTING = 1;

          systemPackages = with pkgs; [
            xwayland-satellite
            file-roller
            nautilus
            satty
            loupe
            dsearch
            pwvucontrol
          ];
        };

        programs = {
          niri.enable = true;
          kdeconnect.enable = true;
        };

        services = {
          accounts-daemon.enable = true;
          greetd.settings.default_session.user = "saluki";
          gvfs.enable = true;
          geoclue2 = {
            enable = true;
            enableDemoAgent = true;
          };
        };
      };

    homeManager =
      {
        pkgs,
        config,
        osConfig,
        ...
      }:
      {
        imports = [ inputs.niri.homeModules.config ];

        dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
        xdg.autostart.enable = true;

        programs.niri = {
          package = osConfig.programs.niri.package;

          settings = {
            input = {
              mouse.accel-profile = "flat";
              warp-mouse-to-focus.enable = true;
              focus-follows-mouse = {
                enable = true;
                max-scroll-amount = "0%";
              };

              touchpad = {
                tap = true;
                drag = true;
                natural-scroll = true;
                click-method = "clickfinger";
                scroll-method = "two-finger";
              };
            };

            cursor.theme = config.home.pointerCursor.name;

            prefer-no-csd = true;

            hotkey-overlay = {
              hide-not-bound = true;
              skip-at-startup = true;
            };

            # Disable middle-click to paste
            clipboard.disable-primary = true;

            layout = {
              border = {
                enable = false;
                width = 1;
              };

              focus-ring = {
                enable = true;
                width = 2;
              };

              shadow.enable = true;

              gaps = 8;

              default-column-width.proportion = 0.66667;
              tab-indicator.place-within-column = true;
            };

            window-rules = [
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
            ];

            blur = {
              enable = true;
              offset = 2;
            };

            binds = lib.attrsets.mergeAttrsList [
              {
                "Mod+Q".action.close-window = [ ];

                #"Mod+Shift+Space".action.spawn-sh = "systemctl --user restart vicinae.service";

                "Mod+Return".action.spawn = "alacritty";

                "Mod+W".action.toggle-overview = [ ];
                "Mod+O".action.show-hotkey-overlay = [ ];
                
                "Mod+S".action.screenshot-window = [ ];
                "Mod+Ctrl+S".action.spawn-sh = "niri msg action screenshot-screen && wl-paste | satty -f -";

                "Mod+Shift+T".action.toggle-column-tabbed-display = [ ];

                "Mod+G".action.switch-focus-between-floating-and-tiling = [ ];

                "Mod+H".action.focus-column-or-monitor-left = [ ];
                "Mod+J".action.focus-window-or-workspace-down = [ ];
                "Mod+K".action.focus-window-or-workspace-up = [ ];
                "Mod+L".action.focus-column-or-monitor-right = [ ];

                "Mod+Shift+H".action.move-column-or-to-monitor-left = [ ];
                "Mod+Shift+J".action.move-window-or-to-workspace-down = [ ];
                "Mod+Shift+K".action.move-window-or-to-workspace-up = [ ];
                "Mod+Shift+L".action.move-column-or-to-monitor-right = [ ];

                "Mod+WheelScrollDown".action.focus-column-right = [ ];
                "Mod+WheelScrollUp".action.focus-column-left = [ ];
              }

              (niri-lib.binds {
                suffixes."H" = "monitor-left";
                suffixes."J" = "monitor-down";
                suffixes."K" = "monitor-up";
                suffixes."L" = "monitor-right";
                prefixes."Mod+Ctrl" = "focus";
                prefixes."Mod+Ctrl+Shift" = "move-column-to";
              })

              (niri-lib.binds {
                suffixes."Home" = "first";
                suffixes."End" = "last";
                prefixes."Mod" = "focus-column";
                prefixes."Mod+Ctrl" = "move-column-to";
              })

              (niri-lib.binds {
                suffixes = builtins.listToAttrs (
                  map (n: {
                    name = toString n;
                    value = [
                      "workspace"
                      n
                    ];
                  }) (lib.range 1 9)
                );
                prefixes."Mod" = "focus";
                prefixes."Mod+Shift" = "move-column-to";
              })

              {
                "Mod+Comma".action.consume-window-into-column = [ ];
                "Mod+Period".action.expel-window-from-column = [ ];

                "Mod+R".action.switch-preset-column-width = [ ];
                "Mod+E".action.switch-preset-column-width-back = [ ];
                "Mod+F".action.maximize-column = [ ];
                "Mod+Shift+F".action.fullscreen-window = [ ];
                "Mod+C".action.center-column = [ ];
                "Mod+T".action.toggle-window-floating = [ ];

                "Mod+Shift+Escape".action.toggle-keyboard-shortcuts-inhibit = [ ];
                "Mod+Shift+Ctrl+T".action.toggle-debug-tint = [ ];
                "Ctrl+Alt+Delete".action.quit = [ ];
              }
            ];
          };
        };
      };

  };
}