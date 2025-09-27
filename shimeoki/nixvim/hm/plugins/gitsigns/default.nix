{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    inherit (plugins) gitsigns;
in
{
    imports = [
        ./lazy-load.nix
    ];

    options.shimeoki.nixvim.plugins.gitsigns = {
        enable = lib.mkEnableOption "gitsigns" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf gitsigns.enable {
        programs.nixvim.plugins.gitsigns.enable = true;
    };
}
