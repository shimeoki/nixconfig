{
    config,
    pkgs,
    lib,
    ...
}:
let
    cfg = config.shimeoki.yazi.plugins.full-border;
in
{
    options.shimeoki.yazi.plugins.full-border = {
        enable = lib.mkEnableOption "full-border";
    };

    config = lib.mkIf cfg.enable {
        programs.yazi = {
            plugins = { inherit (pkgs.yaziPlugins) full-border; };
        };
    };
}
