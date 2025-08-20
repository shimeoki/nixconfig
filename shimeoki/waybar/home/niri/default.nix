{ config, lib, ... }:
let
    inherit (config.shimeoki) niri;
in
{
    imports = [
        ./language.nix
    ];

    options.shimeoki.waybar.niri = {
        enable = lib.mkEnableOption "niri" // {
            default = niri.enable;
        };
    };
}
