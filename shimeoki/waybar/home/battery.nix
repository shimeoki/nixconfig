{ config, lib, ... }:
let
    inherit (config.shimeoki) waybar;

    capacity = icon: "{capacity}% ${icon}";
in
{
    # todo: check for laptop

    options.shimeoki.waybar.battery = {
        enable = lib.mkEnableOption "battery" // {
            default = waybar.enable;
        };
    };

    config = {
        programs.waybar.settings.main.battery = {
            states = {
                charge-100 = 100;
                charge-99 = 99;
                charge-89 = 89;
                charge-79 = 79;
                charge-69 = 69;
                charge-59 = 59;
                charge-49 = 49;
                charge-39 = 39;
                charge-29 = 29;
                charge-19 = 19;
                charge-9 = 9;
            };

            format-charge-100 = capacity "󰁹";
            format-charge-99 = capacity "󰂂";
            format-charge-89 = capacity "󰂁";
            format-charge-79 = capacity "󰂀";
            format-charge-69 = capacity "󰁿";
            format-charge-59 = capacity "󰁾";
            format-charge-49 = capacity "󰁽";
            format-charge-39 = capacity "󰁼";
            format-charge-29 = capacity "󰁻";
            format-charge-19 = capacity "󰁺";
            format-charge-9 = capacity "󰂎";

            format-charging-charge-100 = capacity "󰂅";
            format-charging-charge-99 = capacity "󰂋";
            format-charging-charge-89 = capacity "󰂊";
            format-charging-charge-79 = capacity "󰢞";
            format-charging-charge-69 = capacity "󰂉";
            format-charging-charge-59 = capacity "󰢝";
            format-charging-charge-49 = capacity "󰂈";
            format-charging-charge-39 = capacity "󰂇";
            format-charging-charge-29 = capacity "󰂆";
            format-charging-charge-19 = capacity "󰢜";
            format-charging-charge-9 = capacity "󰢟";
        };
    };
}
