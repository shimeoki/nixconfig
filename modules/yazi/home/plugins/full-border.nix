{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config.shimeoki.yazi) plugins;
    cfg = plugins.full-border;
in
{
    options.shimeoki.yazi.plugins.full-border = {
        enable = lib.mkEnableOption "full-border" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.yazi = {
            plugins = { inherit (pkgs.yaziPlugins) full-border; };
        };
    };
}
