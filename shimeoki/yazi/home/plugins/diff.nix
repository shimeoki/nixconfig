{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config.shimeoki.yazi) plugins;
    cfg = plugins.diff;
    bind = {
        on = [ "<C-d>" ];
        run = "plugin diff";
    };
in
{
    options.shimeoki.yazi.plugins.diff = {
        enable = lib.mkEnableOption "diff" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.yazi = {
            plugins = { inherit (pkgs.yaziPlugins) diff; };
            keymap.mgr.prepend_keymap = [ bind ];
        };
    };
}
