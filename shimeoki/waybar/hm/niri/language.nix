{ config, lib, ... }:
let
    inherit (config.shimeoki.waybar) niri;
    cfg = niri.language;
in
{
    options.shimeoki.waybar.niri.language = {
        enable = lib.mkEnableOption "language" // {
            default = niri.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.waybar.settings.main."niri/language" = {
            format = "{}";
            format-en = "en";
            format-ru = "ru";
            on-click = "niri msg action switch-layout next";
        };
    };
}
