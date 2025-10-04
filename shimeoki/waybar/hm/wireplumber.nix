{ config, lib, ... }:
let
    inherit (config.shimeoki) waybar pwvucontrol;

    mute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
in
{
    # todo: check for audio?

    options.shimeoki.waybar.wireplumber = {
        enable = lib.mkEnableOption "wireplumber" // {
            default = waybar.enable;
        };
    };

    config = {
        programs.waybar.settings.main.wireplumber = {
            format = "{volume}% {icon}";
            format-muted = "{volume}% 󰝟";
            format-icons = [
                "󰕿"
                "󰖀"
                "󰕾"
            ];
            scroll-step = 5;
            on-click = if pwvucontrol.enable then "pwvucontrol" else mute;
            on-click-right = mute;
            tooltip = false;
            reverse-scrolling = true;
        };
    };
}
