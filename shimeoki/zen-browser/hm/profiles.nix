{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config.shimeoki) zen-browser;

    searchNixpkgs = {
        name = "nixpkgs";
        urls = [
            {
                template = "https://search.nixos.org/packages";
                params = [
                    {
                        name = "type";
                        value = "packages";
                    }
                    {
                        name = "query";
                        value = "{searchTerms}";
                    }
                ];
                definedAliases = [ "@np" ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            }
        ];
    };

    searchNixwiki = {
        name = "nixwiki";
        urls = [
            {
                teamplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
            }
        ];
        iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
        definedAliases = [ "@nw" ];
    };
in
{
    config = lib.mkIf zen-browser.enable {
        programs.zen-browser.profiles.main = {
            id = 0;
            search = {
                force = true;
                default = "ddg";
                privateDefault = "ddg";
                order = [
                    "ddg"
                    "google"
                ];
                engines = {
                    nixpkgs = searchNixpkgs;
                    nixwiki = searchNixwiki;
                    bing.metaData.hidden = true;
                    google.metaData.alias = "@g";
                };
            };
        };
    };
}
