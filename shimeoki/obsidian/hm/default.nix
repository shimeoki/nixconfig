{ config, lib, ... }:
let
    inherit (config) shimeoki;
    inherit (shimeoki) obsidian;
in
{
    options.shimeoki.obsidian = {
        enable = lib.mkEnableOption "obsidian" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf obsidian.enable {
        programs.obsidian.enable = true;
    };
}
