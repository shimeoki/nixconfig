{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config.shimeoki.yazi) plugins;
    cfg = plugins.ouch;
    bind = {
        on = [ "C" ];
        run = "plugin ouch";
    };
in
{
    options.shimeoki.yazi.plugins.ouch = {
        enable = lib.mkEnableOption "ouch" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.ouch ];
        programs.yazi = {
            plugins = { inherit (pkgs.yaziPlugins) ouch; };
            keymap.mgr.prepend_keymap = [ bind ];
        };
    };
}
