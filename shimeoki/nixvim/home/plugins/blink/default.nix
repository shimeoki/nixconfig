{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.blink;
in
{
    imports = [
        ./binds.nix
        ./sources.nix
        ./completion.nix
        ./lazy-load.nix
    ];

    options.shimeoki.nixvim.plugins.blink = {
        enable = lib.mkEnableOption "blink" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.blink-cmp.enable = true;
    };
}
