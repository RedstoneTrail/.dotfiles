{
  pkgs,
  config,
  ...
}:
{
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-GB"
      "en-US"
    ];
    nativeMessagingHosts.packages = with pkgs; [ tridactyl-native ];
    policies = {
      DisablePocket = true;
      Handlers = {
        extensions = {
          pdf = {
            action = "useSystemDefault";
          };
        };
        schemes = {
          mailto = {
            action = "useHelperApp";
            ask = true;
            handlers = [
              {
                name = "Gmail";
                uriTemplate = "https://mail.google.com/mail/?extsrc=mailto&url=%s";
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
