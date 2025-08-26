{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) fzf;
in
{
    imports = [
        ./binds.nix
        ./fd.nix
        ./preview.nix
    ];

    options.shimeoki.fzf = {
        enable = lib.mkEnableOption "fzf" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf fzf.enable {
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
