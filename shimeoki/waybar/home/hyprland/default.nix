{ lib, ... }:
{
    # todo: check for hyprland

    imports = [
        ./language.nix
        ./workspaces.nix
        ./window.nix
    ];

    options.shimeoki.waybar.hyprland = {
        enable = lib.mkEnableOption "hyprland";
    };
}
