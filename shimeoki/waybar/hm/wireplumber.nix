{ config, lib, ... }:
let
    inherit (config.shimeoki) waybar;
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
            # todo: pwvucontrol
            # todo: wpctl
            tooltip = false;
            reverse-scrolling = false;
        };
    };
}
