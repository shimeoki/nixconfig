{
    config,
    lib,
    ...
}:
let
    cfg = config.shimeoki.kitty;
in
{
    imports = [
        ./fonts.nix
        ./binds.nix
        ./cursor.nix
        ./bell.nix
        ./layout.nix
        ./tabs.nix
    ];

    options.shimeoki.kitty = {
        enable = lib.mkEnableOption "kitty";
    };

    config = lib.mkIf cfg.enable {
        programs.kitty.enable = true;
    };
}
