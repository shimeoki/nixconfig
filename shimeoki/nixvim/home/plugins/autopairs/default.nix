{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.autopairs;
in
{
    options.shimeoki.nixvim.plugins.autopairs = {
        enable = lib.mkEnableOption "autopairs" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.nvim-autopairs.enable = true;
    };
}
