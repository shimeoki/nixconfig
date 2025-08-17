{
    config,
    pkgs,
    lib,
    ...
}:
let
    cfg = config.shimeoki.yazi.plugins.diff;
    bind = {
        on = [ "<C-d>" ];
        run = "plugin diff";
    };
in
{
    options.shimeoki.yazi.plugins.diff = {
        enable = lib.mkEnableOption "diff";
    };

    config = lib.mkIf cfg.enable {
        programs.yazi = {
            plugins = { inherit (pkgs.yaziPlugins) diff; };
            keymap.mgr.prepend_keymap = [ bind ];
        };
    };
}
