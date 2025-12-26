{
  pkgs,
  ...
}:
{
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
      SearchEngines = {
        Default = "Mojeek";
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
      };
      Preferences =
        let
          value = val: {
            Value = val;
            Status = "locked";
          };
        in
        {
          "browser.startup.homepage" = value "file:///home/redstonetrail/.dotfiles/firefox/newtab.html";
          "browser.newtab.url" = value "file:///home/redstonetrail/.dotfiles/firefox/newtab.html";
          "browser.newtabpage.enabled" = value false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = value true;
          "browser.toolbars.bookmarks.visibility" = value "never";
          "browser.ml.chat.enabled" = value false;
          "browser.ml.chat.menu" = value false;
          "browser.ml.chat.sidebar" = value false;
          "sidebar.notification.badge.aichat" = value false;
          "browser.bookmarks.restore_default_bookmarks" = value false;
        };
    };
  };
}
