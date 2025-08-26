{ config, lib, ... }:
let
    inherit (config.shimeoki) waybar;
in
{
    options.shimeoki.waybar.keyboard-state = {
        enable = lib.mkEnableOption "keyboard-state" // {
            default = waybar.enable;
        };
    };

    config = {
        programs.waybar.settings.main.keyboard-state = {
            capslock = true;
            format.capslock = "caps {icon}";
            format-icons = {
                locked = "󰌾";
                unlocked = "󰿆";
            };
        };
    };
}
