{
    config,
    pkgs,
    lib,
    ...
}:
let
    cfg = config.shimeoki.yazi.plugins.git;
    bind = {
        on = [
            "g"
            "r"
        ];
        run = ''shell -- ya emit cd "$(git rev-parse --show-toplevel)"'';
    };
in
{
    options.shimeoki.yazi.plugins.git = {
        enable = lib.mkEnableOption "git";
    };

    config = lib.mkIf cfg.enable {
        shimeoki.git.enable = lib.mkForce true;
        programs.yazi = {
            settings.plugin.prepend_fetchers = [
                {
                    id = "git";
                    name = "*";
                    run = "git";
                }
                {
                    id = "git";
                    name = "*/";
                    run = "git";
                }
            ];
            plugins = { inherit (pkgs.yaziPlugins) git; };
            keymap.mgr.prepend_keymap = [ bind ];
        };
    };
}
