{ config, lib, ... }:
let
    inherit (config.shimeoki) waybar;
in
{
    # todo: check for bluetooth

    options.shimeoki.waybar.bluetooth = {
        enable = lib.mkEnableOption "bluetooth" // {
            default = waybar.enable;
        };
    };

    config = {
        programs.waybar.settings.main.bluetooth = {
            format = "{status} 󰂯";
            format-no-controller = "";
            format-disabled = "";
            format-off = "";
            format-connected = "{device_alias} 󰂱";
            format-connected-battery = "{device_alias} 󰂱 {device_battery_percentage}% 󰥉";
        };
    };
}
