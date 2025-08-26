{ config, lib, ... }:
let
    inherit (config.shimeoki.waybar) hyprland;
    cfg = hyprland.window;
in
{
    # todo: check for kitty

    options.shimeoki.waybar.hyprland.window = {
        enable = lib.mkEnableOption "window" // {
            default = hyprland.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.waybar.settings.main."hyprland/window" = {
            format = "{}";
            separate-outputs = true;
            icon = false;
            on-click = "hyprctl dispatch exec kitty --detach";
            on-click-right = "hyprctl dispatch movetoworkspacesilent special:S";
            on-click-middle = "hyprctl dispatch killactive";
        };
    };
}
