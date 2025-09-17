{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.notify;
in
{
    imports = [
        ./lazy-load.nix
    ];

    options.shimeoki.nixvim.plugins.notify = {
        enable = lib.mkEnableOption "notify" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.notify = {
            enable = true;
            settings = {
                fps = 60; # FIX: author specific

                # NOTE: probably should only be used if the colors are
                # configured to be transparent. not tested. included to just
                # get rid of the annoying warning notification.
                background_colour = "#000000";
            };
        };
    };
}
