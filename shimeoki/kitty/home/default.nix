{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.kitty;
in
{
    imports = [
        ./fonts.nix
        ./binds.nix
        ./cursor.nix
        ./bell.nix
        ./layout.nix
        ./tabs.nix
        ./aliases.nix
        ./stylix.nix
    ];

    options.shimeoki.kitty = {
        enable = lib.mkEnableOption "kitty" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.kitty.enable = true;
    };
}
