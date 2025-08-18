{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.indent-blankline;
in
{
    options.shimeoki.nixvim.plugins.indent-blankline = {
        enable = lib.mkEnableOption "indent-blankline" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.indent-blankline.enable = true;
    };
}
