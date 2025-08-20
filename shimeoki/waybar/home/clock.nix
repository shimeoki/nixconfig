{ config, lib, ... }:
let
    inherit (config.shimeoki) waybar;
in
{
    options.shimeoki.waybar.clock = {
        enable = lib.mkEnableOption "clock" // {
            default = waybar.enable;
        };
    };

    config = {
        programs.waybar.settings.main.clock = {
            interval = 60;
            tooltip = true;
            format = "{:%R}";
            tooltip-format = "{:%F (%A, %B %d)}";
        };
    };
}
