{ config, lib, ... }:
let
    inherit (config.shimeoki) waybar dotfiles;
in
{
    # todo: check for cava and mpd

    options.shimeoki.waybar.cava = {
        enable = lib.mkEnableOption "cava" // {
            default = waybar.enable;
        };
    };

    config = {
        programs.waybar.settings.main.cava = {
            cava_config = dotfiles.config "cava/config";
            method = "fifo";
            source = "/tmp/mpd.fifo";
            sensitivity = 3;
            bars = 24;
            bar_delimeter = 0;
            format-icons = [
                "▁"
                "▂"
                "▃"
                "▄"
                "▅"
                "▆"
                "▇"
            ];
            input_delay = 2;
            hide_on_silence = true;
            sleep_timer = 5;
        };
    };
}
