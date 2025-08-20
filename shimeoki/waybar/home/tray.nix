{ config, lib, ... }:
let
    inherit (config.shimeoki) waybar;
in
{
    options.shimeoki.waybar.tray = {
        enable = lib.mkEnableOption "tray" // {
            default = waybar.enable;
        };
    };

    config = {
        programs.waybar.settings.main.tray = {
            icon-size = 16;
            spacing = 12;
            show-passive-items = true;
            reverse-direction = true;
        };
    };
}
