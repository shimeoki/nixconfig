{ config, lib, ... }:
with lib;
let
    cfg = config.shimeoki.waybar;

    modules-left =
        optional cfg.wireplumber.enable "wireplumber"
        # style: usage of lib for the formatting
        ++ lib.optional cfg.mpd.enable "mpd";

    modules-center =
        optional cfg.clock.enable "clock"
        ++ optional cfg.hyprland.language.enable "hyprland/language"
        ++ optional cfg.niri.language.enable "niri/language"
        ++ optional cfg.keyboard-state.enable "keyboard-state";

    modules-right =
        optional cfg.bluetooth.enable "bluetooth"
        ++ optional cfg.network.enable "network"
        ++ optional cfg.cava.enable "cava"
        ++ optional cfg.backlight.enable "backlight"
        ++ optional cfg.battery.enable "battery"
        ++ optional cfg.tray.enable "tray";
in
{
    config = {
        programs.waybar.settings.main = {
            inherit modules-left modules-center modules-right;
        };
    };
}
