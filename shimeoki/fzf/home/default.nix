{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.fzf;
in
{
    imports = [
        ./binds.nix
    ];

    options.shimeoki.fzf = {
        enable = lib.mkEnableOption "fzf" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.fzf = {
            enable = true;
            defaultOptions = [
                "--reverse"
                "--multi"
                "--cycle"
                "--wrap"
                "--ellipsis='...'"
                "--highlight-line"
                "--scroll-off=5"
                "--no-scrollbar"
                "--info=inline-right"
                "--prompt='> '"
                "--pointer=''"
                "--no-separator"
                "--marker='> '"
                "--marker-multi-line='> |'"
                "--tabstop=4"
                "--border=none"
                "--list-border=none"
                "--input-border=none"
                "--preview-border=none"
                "--preview-window='right,60%,border-none,wrap,<80(down,border-none,50%,wrap)'"
            ];
        };
    };
}
