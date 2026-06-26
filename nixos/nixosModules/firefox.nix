{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.dotfiles.web;
  genAttrsConst = keys: value: lib.attrsets.genAttrs keys (_: value);
in
{
  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      languagePacks = [
        "en-US"
        "en-GB"
      ];
      nativeMessagingHosts.packages = with pkgs; [ tridactyl-native ];
      policies = {
        DisablePocket = true;
        DisableTelemetry = true;
        GenerativeAI = {
          Enabled = false;
          Chatbot = false;
          LinkPreviews = false;
          TabGroups = false;
          Locked = true;
        };
        Homepage = {
          URL = "file:///home/redstonetrail/.dotfiles/firefox/newtab.html";
          Locked = true;
          StartPage = "homepage";
        };
        ShowHomeButton = false;
        SearchEngines = {
          Default = "Brave";
          Add = [
            {
              Name = "Mojeek";
              URLTemplate = "https://www.mojeek.com/search?q={searchTerms}";
            }
            {
              Name = "Brave";
              URLTemplate = "https://search.brave.com/search?q={searchTerms}";
            }
          ];
        };
        Handlers = {
          extensions = {
            pdf = {
              action = "useSystemDefault";
            };
          };
          schemes = {
            mailto = {
              action = "useHelperApp";
              ask = false;
              handlers = [
                {
                  name = "aerc";
                  path = "~/.dotfiles/scripts/send-mail";
                }
              ];
            };
          };
          mimeTypes = {
            # test
            "text/*" = {
              action = "useHelperApp";
              ask = false;
              handlers = [
                {
                  name = "nvim";
                  path = "/bin/nvim";
                }
              ];
            };
          }
          // (genAttrsConst
            [
              "image/png"
              "image/jpeg"
              "image/webp"
              "image/avif"
              "image/gif"
              "video/vnd.avi"
              "video/mp4"
              "video/mpeg"
              "video/webm"
              "video/ogg"
              "audio/mp4"
              "audio/x-mpegurl"
              "audio/x-flac"
              "audio/x-wav"
              "audio/x-opus+ogg"
              "audio/mpeg"
              "audio/ogg"
              "audio/vnd.wave"
            ]
            {
              action = "useHelperApp";
              ask = false;
              handlers = [
                {
                  name = "mpv";
                  path = "/bin/mpv";
                }
              ];
            }
          );
        };
        ExtensionSettings = {
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          # Tridactyl
          "tridactyl.vim@cmcaine.co.uk" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/tridactyl_vim/latest.xpi";
            installation_mode = "force_installed";
          };
          "greenstorm@vimfordocs.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4619794/vim_for_docs-2.2.xpi";
            installation_mode = "force_installed";
          };
          "zotero@chnm.gmu.edu" = {
            install_url = "https://www.zotero.org/download/connector/dl?browser=firefox&version=5.0.210";
            installation_mode = "force_installed";
          };
        };
        Preferences =
          let
            value = val: {
              Value = val;
              Status = "locked";
            };
          in
          {
            # "browser.startup.homepage" = value "file:///home/redstonetrail/.dotfiles/firefox/newtab.html";
            # "browser.newtab.url" = value "file:///home/redstonetrail/.dotfiles/firefox/newtab.html";
            # "browser.newtabpage.enabled" = value false;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = value true;
            "browser.toolbars.bookmarks.visibility" = value "never";
            "sidebar.notification.badge.aichat" = value false;
            "browser.bookmarks.restore_default_bookmarks" = value false;
          };
      };
    };
  };
}
