{ config, lib, ... }:
let
    inherit (config.shimeoki.waybar) hyprland;
    cfg = hyprland.language;
in
{
    # todo: check for kanata

    options.shimeoki.waybar.hyprland.language = {
        enable = lib.mkEnableOption "language" // {
            default = hyprland.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.waybar.settings.main."hyprland/language" = {
            format = "{}";
            format-en = "en";
            format-ru = "ru";
            on-click = "hyprctl switchxkblayout kanata next";
        };
    };
}
