{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    inherit (plugins) friendly-snippets;
in
{
    options.shimeoki.nixvim.plugins.friendly-snippets = {
        enable = lib.mkEnableOption "friendly-snippets" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf friendly-snippets.enable {
        programs.nixvim.plugins.friendly-snippets.enable = true;
    };
}
