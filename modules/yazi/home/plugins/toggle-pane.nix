{
    config,
    pkgs,
    lib,
    ...
}:
let
    cfg = config.shimeoki.yazi.plugins.toggle-pane;
    setMin = {
        on = [ "<C-t>" ];
        run = "plugin toggle-pane min-preview";
    };
    setMax = {
        on = [ "T" ];
        run = "plugin toggle-pane max-preview";
    };
in
{
    options.shimeoki.yazi.plugins.toggle-pane = {
        enable = lib.mkEnableOption "toggle-pane";
    };

    config = lib.mkIf cfg.enable {
        programs.yazi = {
            plugins = { inherit (pkgs.yaziPlugins) toggle-pane; };
            keymap.mgr.prepend_keymap = [
                setMin
                setMax
            ];
        };
    };
}
