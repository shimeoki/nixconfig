{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.lz-n;
in
{
    options.shimeoki.nixvim.plugins.lz-n = {
        enable = lib.mkEnableOption "lz-n" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins = {
            lz-n.enable = true;
        };
    };
}
