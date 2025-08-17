{ config, lib, ... }:
let
    cfg = config.shimeoki.zen-browser;
in
{
    config = lib.mkIf cfg.enable {
        xdg.mimeApps = {
            enable = lib.mkForce true;
            defaultApplications =
                let
                    browser = "zen-twilight.desktop";
                in
                {
                    "text/html" = browser;
                    "text/xml" = browser;
                    "application/xhtml+xml" = browser;
                    "x-scheme-handler/http" = browser;
                    "x-scheme-handler/https" = browser;
                    "application/x-xpinstall" = browser;
                    "application/pdf" = browser;
                    "application/json" = browser;
                };
        };
    };
}
