{ config, lib, ... }:
let
    inherit (config.shimeoki.waybar) hyprland;
    cfg = hyprland.workspaces;
in
{
    options.shimeoki.waybar.hyprland.workspaces = {
        enable = lib.mkEnableOption "workspaces" // {
            default = hyprland.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.waybar.settings.main."hyprland/workspaces" = {
            format = "{name}{icon}{windows}";
            format-window-separator = " ";
            window-rewrite-default = "󰣆";
            window-rewrite = {
                "class<(firefox|floorp|zen)>" = "󰈹";
                "class<(code)>" = "󰨞";
                "class<(kitty)>" = "󰆍";
                "class<(obsidian)>" = "󰠮";
                "class<(.*telegram.*|.*materialgram)>" = "";
                "class<(element|signal)>" = "󰍩";
                "class<(wofi|albert)>" = "󰮫";
                "class<(steam)>" = "󰓓";
                "class<(discord|vesktop)>" = "󰙯";
                "class<(nekobox)>" = "󰖂";
                "class<(opentabletdriver.*)>" = "󰏬";
                "class<(spotify)>" = "󰓇";
                "class<(gamescope)>" = "󰺵";
                "class<(.*obsproject.*)>" = "󰻂";
            };
            format-icons = {
                default = " ";
                special = " ";
                empty = "";
            };
            on-scroll-up = "hyprctl dispatch workspace m+1";
            on-scroll-down = "hyprctl dispatch workspace m-1";
            show-special = true;
        };
    };
}
