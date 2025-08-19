{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.notify;
in
{
    options.shimeoki.nixvim.plugins.notify = {
        enable = lib.mkEnableOption "notify" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.notify = {
            enable = true;
            settings.fps = 60; # fix: author specific
        };
    };
}
