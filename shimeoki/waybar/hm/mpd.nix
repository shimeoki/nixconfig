{ config, lib, ... }:
let
    inherit (config.shimeoki) waybar;
in
{
    # todo: check for mpd, rmpc and kitty

    options.shimeoki.waybar.mpd = {
        enable = lib.mkEnableOption "mpd" // {
            default = waybar.enable;
        };
    };

    config = {
        programs.waybar.settings.main.mpd = {
            # say thanks to pango for hardcoding colors
            format = "{stateIcon} at <span color=\"#89b4fa\">{volume}%</span> / <b>{title}</b> by <span color=\"#94e2d5\">{artist}</span> from <span color=\"#f5c2e7\">{album}</span> ({elapsedTime:%M:%S} / {totalTime:%M:%S})"; # volume: blue, artist: teal, album: pink
            state-icons = {
                playing = "<span color=\"#a6e3a1\">󰐊</span>"; # green
                paused = "<span color=\"#f9e2af\">󰏤</span>"; # yellow
            };
            format-stopped = "";
            format-disconnected = "";
            tooltip = true;
            tooltip-format = "{repeatIcon}{randomIcon}{consumeIcon}{singleIcon}";
            repeat-icons.on = " repeat ";
            random-icons.on = " random ";
            consume-icons.on = " remove ";
            single-icons.on = " single ";
            tooltip-format-disconnected = "";
            # todo: actions
            max-length = 80;
        };
    };
}
