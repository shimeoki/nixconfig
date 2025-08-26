{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) colorschemes;
    cfg = colorschemes.base16;
in
{
    options.shimeoki.nixvim.colorschemes.base16 = {
        enable = lib.mkEnableOption "base16" // {
            default = colorschemes.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.colorschemes.base16.enable = true;
    };
}
