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
        nixpkgs.config.allowUnfreePredicate =
            pkg: builtins.elem (lib.getName pkg) [ "obsidian" ];
    };
}
