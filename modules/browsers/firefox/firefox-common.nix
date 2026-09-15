{ config, pkgs, lib, ... }:

let
  inherit (lib) mkForce;

  # This handy macro/lambda thing is great for force locking values in Firefox config
  lock-val = value: {
    Value = value;
    Status = "locked";
  };

  # Nice macro for github URLs
  githubRaw = owner: repo: branch: path:
    "https://raw.githubusercontent.com/${owner}/${repo}/${branch}/${path}";
in

{
  programs.firefox = {
    /* ---- POLICIES ---- */
      policies = {
        /* ---- NIX COMPLIANCE ---- */
        AppAutoUpdate = false;
        BackgroundAppUpdate = false;
        DisableAppUpdate = true;
        DisableSetDesktopBackground = true;
        DisableProfileRefresh = true; # Disable button to "refresh" profile in settings page and about:support

        /* ---- PRIVACY ---- */
        DisableFirefoxAccounts = true; # Disable Firefox Sync
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisableFirefoxScreenshots = true;
        DisablePocket = true;
        DisableTelemetry = true;

        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          EmailTracking = true;
          Fingerprinting = true;
          SuspectedFingerprinting = true;
          # Exceptions = ["https://example.com"]
        };

        /* ---- ANNOYANCES ---- */
        DontCheckDefaultBrowser = true; # leave me alone man

        GenerativeAI = {
          Enabled = false;
          # These next ones shouldn't be necessary but the firefox docs do not make it clear, so. Better safe than sorry.
          Chatbot = false; # Controls access to AI chatbots in the sidebar
          LinkPreviews = false; # Controls AI generation of link previews
          TabGroups = false; # Controls AI name suggestions for tab groups
          # And of course, forcefully lock this setting
          Locked = true;
        };

        FirefoxSuggest = {
          WebSuggestions = false;
          SponsoredSuggestions = false; # fuck off
          ImproveSuggest = false;
          Locked = true;
        };

        /* ---- SECURITY ---- */
        # No builtin PDF viewer
        DisableBuiltinPDFViewer = true;
        # No Autofill
        AutofillAddressesEnabled = false;
        AutofillCreditCardEnabled = false;
        PasswordManagerEnabled = false;
        OfferToSaveLogins = false;
        DisableMasterPasswordCreation = true;
        DisablePasswordReveal = true;

        PDFjs = {
          Enabled = false; # not a chance
          EnablePermissions = false; # nah
        };

        EncryptedMediaExtensions = {
          Enabled = true;
          Locked = true;
        };


        /* ---- EXTRA OVERRIDES VIA FLAGS ---- */
        Preferences = {
          # Convenience
          "general.autoScroll" = true;
          "general.useragent.locale" = lock-val "en-US";
          "distribution.searchplugins.defaultLocale" = lock-val "en-US";
          "browser.urlbar.suggest.calculator" = true;

          # Privacy tweaks
          "browser.search.suggest.enabled.private" = lock-val false; # Do not allow search suggestions in private browsing

          "cookiebanners.service.mode" = lock-val 2; # Block cookie banners
          "cookiebanners.service.mode.privateBrowsing" = lock-val 2; # Block cookie banners in private browsing
          "privacy.donottrackheader.enabled" = lock-val true;
          "privacy.resistFingerprinting" = lock-val true;
          "privacy.globalprivacycontrol.enabled" = lock-val true;
          "network.dns.disableIPv6" = lock-val true;

          ## Forcefully disable Normandy, aka Firefox Shield
          "app.normandy.api_url" = lock-val "";
          "app.normandy.enabled" = lock-val false;
          "app.normandy.dev_mode" = lock-val false;
          "app.normandy.first_run" = lock-val false;

          ## Personalized extension recommendations (no thank you)
          "browser.discovery.enabled" = lock-val false;
          "extrensions.getAddons.showPane" = lock-val false;
          "extensions.htmlaboutaddons.recommendations.enabled" = lock-val false;


          # Enforce password manager policies that are missed by the "easy" config options
          "services.sync.engine.passwords" = lock-val false;

          # Disable AI Bullshit
          "browser.ml.enable" = lock-val false;
          "browser.ml.chat.menu" = lock-val false;
          "browser.ml.chat.prompt.prefix" = lock-val "";
          "browser.ml.chat.prompts.0" = lock-val "";
          "browser.ml.chat.prompts.1" = lock-val "";
          "browser.ml.chat.prompts.2" = lock-val ""; # This is weirdly maybe not defined in a standard firefox or librewolf install but. Zero it out anyways
          "browser.ml.chat.prompts.3" = lock-val "";
          "browser.ml.chat.prompts.4" = lock-val "";
          "browser.ml.chat.sidebar" = lock-val false;
          "browser.ml.chat.shortcuts" = lock-val false;
          "browser.ml.chat.shortcuts.custom" = lock-val false;
          "browser.ml.chat.shortcuts.smartwindow" = lock-val false;
          "browser.ml.linkPreview.enabled" = lock-val false;
          "browser.ml.linkPreview.allowedLanguages" = lock-val "";
          "browser.ml.pageAssist.enabled" = lock-val false;
          ## No models for you
          "browser.ml.chat.provider" = lock-val "";
          "browser.ml.modelHubRootUrl" = lock-val "";
          "browser.ml.modelHubUrlTemplate" = lock-val "";
          "extensions.ml.enabled" = lock-val false;
          # Disable other builtin annoyances
          "browser.topsites.contile.enabled" = lock-val false;

          # Yubikey and Trezor
          "security.webauth.u2f" = true;
          "security.webauth.webauthn" = true;
          "security.webauth.webauthn_enable_softtoken" = true;
          "security.webauth.webauthn_enable_usbtoken" = true;
        };
        /* ---- EXTENSIONS ---- */
        ExtensionSettings = with builtins;
          let
            extension = shortId: uuid: {
              name = uuid;
              value = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/${shortId}/latest.xpi";
                installation_mode = "force_installed";
              };
            };
          in
            listToAttrs [
              (extension "duckduckgo-for-firefox" "jid1-ZAdIEUB7XOzOJw@jetpack")
              (extension "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
              (extension "ublock-origin" "uBlock0@raymondhill.net")
              (extension "decentraleyes" "jid1-BoFifL9Vbdl2zQ@jetpack")
              (extension "darkreader" "addon@darkreader.org")
            ];
        "3rdparty".Extensions = {
          "uBlock0@raymondhill.net".adminSettings = rec {
            userSettings = {
              uiTheme = "dark";
              uiAccentCustom = true;
              uiAccentCustom0 = "#8300ff";
              cloudStorageEnabled = mkForce false; # Possibly security liability

              externalLists = lib.concatStringsSep "\n" importedLists;
            };

            dandelionLists = map (githubRaw "DandelionSprout" "adfilt" "master") [
              "Anti-'Battle Royale' List.txt"
              "Anti-Futa List.txt"
              "AntiAbusePorn.txt"
              "AntiAdoptablesList.txt"
              "AntiAnthroCombatWaifuList.txt"
              "AntiFakeTransparentImagesList.txt"
              "EmptyPaddingRemover.txt"
              "LegitimateURLShortener.txt"
              "Sensitive lists/TabloidRemover.txt"
            ];

            importedLists = [
              # Add other imports here
            ]
            ++ dandelionLists;

            selectedFilterLists = [
              "adguard-generic"
              "adguard-annoyance"
              "adguard-social"
              "adguard-spyware-url"
              "easylist"
              "easylist-annoyances"
              "easyprivacy"
              "fanboy-ai-suggestions"
              "plowe-0" # Peter Lowe's list
              "ublock-abuse"
              "ublock-annoyances"
              "ublock-badware"
              "ublock-filters"
              "ublock-privacy"
              "ublock-quick-fixes"
              "ublock-unbreak"
              "urlhaus-1"
            ]
            ++ importedLists;
          };
        };

        FirefoxHome = {
          Search = true;
          TopSites = true;
          SponsoredTopSites = false; # Lol no
          Highlights = true;
          Pocket = false; # Not happening
          SponsoredPocket = false; # Do you take me for a fool
          Snippets = false;
          Stories = false;
          SponsoredStories = false; # absolutely not
          Locked = true;
        };

        Handlers = {
          mimeTypes."application/pdf".action = "saveToDisk";
        };

        extensions = {
          pdf = {
            action = "useHelperApp";
            ask = true;
            handlers = [
              {
                name = "Okular Document Viewer";
                path = "${pkgs.kdePackages.okular}/bin/okular";
              }
            ];
          };
        };

        PictureInPicture = {
          Enabled = true;
          Locked = true;
        };

        UserMessaging = {
          ExtensionRecommendations = false; # Don’t recommend extensions while the user is visiting web pages
          FeatureRecommendations = false; # Don’t recommend browser features
          MoreFromMozilla = false; # Don’t show the “More from Mozilla” section in Preferences
          SkipOnboarding = true; # Don’t show onboarding messages on the new tab page
          UrlbarInterventions = false; # Don’t offer suggestions in the URL bar
          WhatsNew = false; # Remove the “What’s New” icon and menuitem
          Locked = true; # Prevent the user from changing user messaging preferences
        };

        UseSystemPrintDialog = true;

      };
  };
}