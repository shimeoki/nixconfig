{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.surround;
in
{
    imports = [
        ./lazy-load.nix
    ];

    options.shimeoki.nixvim.plugins.surround = {
        enable = lib.mkEnableOption "surround" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.nvim-surround.enable = true;
    };
}
