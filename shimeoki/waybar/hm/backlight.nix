{ config, lib, ... }:
let
    inherit (config.shimeoki) waybar;
in
{
    # todo: check for laptop

    options.shimeoki.waybar.backlight = {
        enable = lib.mkEnableOption "backlight" // {
            default = waybar.enable;
        };
    };

    config = {
        programs.waybar.settings.main.backlight = {
            format = "{percent}% {icon}";
            format-icons = [
                "󰃚"
                "󰃛"
                "󰃜"
                "󰃝"
                "󰃞"
                "󰃟"
                "󰃠"
            ];
        };
    };
}
