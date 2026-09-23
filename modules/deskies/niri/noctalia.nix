{ inputs, ... }:
{
  flux.niri._.noctalia = {
    nixos =
    { pkgs, ... }: {
      services.displayManager.noctalia-greeter = {
        enable = true;

        extraArgs = "";

        settings = {
          cursor = {
            theme = "Bibata-Modern";
            size = 24;
            path = "${pkgs.bibata-cursors}/share/icons";
          };
        };
      };
    };

    homeManager = { pkgs, lib, ... }: {
      xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;
      programs = {

        noctalia = {
          enable = true;
          systemd.enable = true;

          settings = {
            theme = {
              mode = "dark";
              source = "community";
              builtin = "Tokyo-Night";
              community_palette = "Tokyo Night Storm";

              templates = {
                builtin_ids = [
                  "gtk3"
                  "gtk4"
                  "kcolorscheme"
                  "qt"
                  "niri"
                  "alacritty"
                ];
              };
            };

            wallpaper = {
              enabled = true;
              default.path = inputs.self + "/assets/background.png";
            };

            plugins = {
              enabled = [
                "levi/warp"
                "avivbintangaringga/nix-monitor"
              ];
            };

            shell = {
              polkit_agent = true;

              corner_radius_scale = 1.1;

              session.actions = [
                {
                  action = "lock";
                  enabled = true;

                  countdown_seconds = 0.0;

                  shortcut = "1";
                  variant = "default";
                }

                {
                  action = "logout";
                  enabled = true;

                  countdown_seconds = 0.0;

                  shortcut = "2";
                  variant = "default";
                }

                {
                  action = "lock_and_suspend";
                  enabled = true;

                  countdown_seconds = 0.0;

                  shortcut = "3";
                  variant = "default";
                }

                {
                  action = "reboot";
                  enabled = true;

                  countdown_seconds = 5.0;

                  shortcut = "4";
                  variant = "default";
                }

                {
                  action = "shutdown";
                  enabled = true;

                  countdown_seconds = 5.0;

                  shortcut = "5";
                  variant = "destructive";
                }

                {
                  action = "command";
                  command = "systemctl hibernate";
                  enabled = true;

                  countdown_seconds = 5.0;

                  label = "Hibernate";
                  glyph = "snowflake";

                  shortcut = "6";
                  variant = "default";
                }
              ];
            };

            audio.enable_sounds = true;

            bar.default = {
              background_opacity = 0.85;

              thickness = 36;

              margin_edge = 4;
              margin_ends = 4;

              start = [
                "launcher"
                "group:cpu_status" # CPU Usage + Temp
                "workspaces"
                "active_window"
                "spacer_2"
                "nix-monitor"
              ];

              center = [
                "clipboard"
                "group:timeweather" # Clock + Weather
                "notifications"
                "control-center"
              ];

              end = [
                "tray"
                "group:media_bubble" # Media + Audio Visualizer
                "warp"
                "group:netbt_status" # Network + Bluetooth Status
                "volume"
                "brightness"
                "battery"
                "session"
              ];

              capsule_group = [
                {
                  id = "netbt_status";
                  enabled = true;

                  accordion = false;
                  accordion_direction = "end";

                  fill = "surface_variant";
                  border = "primary";
                  opacity = 1.0;
                  padding = 6.0;

                  members = [
                    "network"
                    "bluetooth"
                  ];
                }

                {
                  id = "timeweather";
                  enabled = true;

                  accordion = false;
                  accordion_direction = "end";

                  fill = "surface_variant";
                  opacity = 1.0;
                  padding = 10.0;

                  members = [
                    "clock"
                    "spacer_center"
                    "weather"
                  ];
                }

                {
                  id = "media_bubble";
                  enabled = true;

                  accordion = false;
                  accordion_direction = "end";

                  fill = "surface_variant";
                  opacity = 1.0;
                  padding = 6.0;

                  members = [
                    "media"
                    "audio-visualizer"
                  ];
                }

                {
                  id = "cpu_status";
                  enabled = true;

                  accordion = true;
                  accordion_direction = "end";

                  fill = "surface_variant";
                  border = "#E8C884";
                  opacity = 1.0;
                  padding = 6.0;

                  members = [
                    "cpu"
                    "temp"
                  ];
                }
              ];
            };

            widget = {
              active_window = {
                enabled = true;
                capsule = true;
                icon_size = 16;
                max_length = 200;
              };

              audio_visualizer = {
                enabled = true;
                bands = 32;
                color_1 = "secondary";
                color_2 = "tertiary";
                mirrored = false;
                width = 64;
              };

              battery = {
                enabled = true;
                capsule = true;
                capsule_border = "on_surface_variant";
                capsule_fill = "surface";
                display_mode = "graphic";
                scale = 0.9;
              };

              brightness = {
                enabled = true;
                icon_color = "#F7EB7A";
                show_label = false;
              };

              clock = {
                enabled = true;
                font_weight = 700;
              };

              control_center = {
                enabled = false;
              };

              launcher = {
                enabled = true;
                capsule = true;
              };

              media = {
                enabled = true;
                color = "primary";
                hide_when_no_media = true;
                max_length = 180;
                show_progress = true;
                title_scroll = "on_hover";
              };

              nix-monitor = {
                enabled = false;
                type = "avivbintangaringga/nix-monitor:nix-monitor";
              };

              session = {
                enabled = true;
                capsule = true;
                capsule_border = "tertiary";
              };

              spacer_center = {
                enabled = true;
                type = "spacer";
              };

              spacer_2 = {
                enabled = false;
                type = "spacer";
                length = 90;
              };

              volume = {
                enabled = true;
                icon_color = "primary";
              };

              warp = {
                enabled = true;
                capsule = true;
                type = "levi/warp:warp";
              };
            };

            battery.warning_threshold = 15;

            dock = {
              position = "left";
              reserve_space = false;
              smart_auto_hide = true;

              magnification_scale = 1.4;
              show_dots = false;
              show_instance_count = true;
            };

            idle = {
              pre_action_fade_seconds = 15;

              behavior_order = [ "screen_off" "lock" "lock-and-suspend" ];
              behavior = {
                screen-off = {
                  enabled = true;
                  action = "screen_off";
                  timeout = 600.0;
                };

                lock = {
                  enabled = false;
                  action = "lock";
                  timeout = 600.0;
                };

                lock-and-suspend = {
                  enabled = true;
                  action = "lock_and_suspend";
                  timeout = 720.0;
                };
              };
            };

            nightlight = {
              temperature_night = 4500;
            };

            weather.unit = "imperial";
          };
        };
        niri.settings.binds =
          let
            msg = cmd: { spawn-sh = "noctalia msg " + cmd; };
          in
          {
            "Mod+Space".action = msg "panel-toggle launcher";
            "Mod+Escape".action = msg "session lock";
            "Mod+V".action = msg "panel-toggle clipboard";
            "Mod+Shift+S".action = msg "screenshot-region";
          };
      };
    };
  };
}
