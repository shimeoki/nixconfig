{ config, lib, ... }:
let
    inherit (config) shimeoki;
    inherit (shimeoki) obsidian syncthing;
in
{
    options.shimeoki.obsidian = {
        enable = lib.mkEnableOption "obsidian" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf obsidian.enable {
        programs.obsidian = {
            inherit (syncthing.obsidian) enable;
        };
    };
}
