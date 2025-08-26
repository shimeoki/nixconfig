{ config, lib, ... }:
let
    inherit (config.shimeoki) waybar;
in
{
    options.shimeoki.waybar.network = {
        enable = lib.mkEnableOption "network" // {
            default = waybar.enable;
        };
    };

    config = {
        programs.waybar.settings.main.network = {
            format-wifi = "{essid} {icon}";
            tooltip-format-wifi = "Signal strength: {signalStrength}%";
            format-ethernet = "{bandwidthTotalBytes} 󰲝";
            format-disconnected = "n/a 󰲜";
            format-icons = [
                "󰤯"
                "󰤟"
                "󰤢"
                "󰤥"
                "󰤨"
            ];
            interval = 5;
        };
    };
}
