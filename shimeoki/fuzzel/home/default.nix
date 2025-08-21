{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.fuzzel;

    padding = 8;
in
{
    imports = [
        ./uwsm.nix
    ];

    options.shimeoki.fuzzel = {
        enable = lib.mkEnableOption "fuzzel" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.fuzzel = {
            enable = true;
            settings = {
                main = {
                    icons-enabled = false;
                    hide-before-typing = false;
                    match-mode = "fzf";

                    tabs = 4;
                    width = 40;
                    lines = 20;

                    horizontal-pad = padding;
                    vertical-pad = padding;
                    inner-pad = padding;
                };
                border = {
                    width = 0;
                    radius = 0;
                };
                key-bindings = {
                    delete-line-forward = "none";
                    next = "Control+j";
                    prev = "Control+k";
                    execute = "Control+l Return";
                };
            };
        };
    };
}
