{
    config,
    pkgs,
    lib,
    ...
}:
let
    cfg = config.shimeoki.yazi.plugins.chmod;
    bind = {
        on = [
            "c"
            "m"
        ];
        run = "plugin chmod";
    };
in
{
    options.shimeoki.yazi.plugins.chmod = {
        enable = lib.mkEnableOption "chmod";
    };

    config = lib.mkIf cfg.enable {
        programs.yazi = {
            plugins = { inherit (pkgs.yaziPlugins) chmod; };
            keymap.mgr.prepend_keymap = [ bind ];
        };
    };
}
