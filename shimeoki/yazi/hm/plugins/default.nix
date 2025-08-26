{
    config,
    lib,
    ...
}:
let
    inherit (config.shimeoki) yazi;
in
{
    imports = [
        ./git.nix
        ./ouch.nix
        ./diff.nix
        ./chmod.nix
        ./toggle-pane.nix
        ./full-border.nix
        # todo: ripdrag & swww
    ];

    options.shimeoki.yazi.plugins = {
        enable = lib.mkEnableOption "plugins" // {
            default = yazi.enable;
        };
    };
}
