{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.telescope;
in
{
    imports = [
        ./binds.nix
    ];

    options.shimeoki.nixvim.plugins.telescope = {
        enable = lib.mkEnableOption "telescope" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.telescope = {
            enable = true;
        };
    };
}
