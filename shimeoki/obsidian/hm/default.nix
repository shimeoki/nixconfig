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
            enable = true;
            vaults.obsidian = {
                inherit (syncthing.obsidian) enable;
                target = "obsidian"; # todo: don't hardcode path
            };
        };
    };
}
