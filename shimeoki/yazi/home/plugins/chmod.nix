{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config.shimeoki.yazi) plugins;
    cfg = plugins.chmod;
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
        enable = lib.mkEnableOption "chmod" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.yazi = {
            plugins = { inherit (pkgs.yaziPlugins) chmod; };
            keymap.mgr.prepend_keymap = [ bind ];
        };
    };
}
