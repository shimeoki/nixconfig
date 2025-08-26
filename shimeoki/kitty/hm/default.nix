{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) kitty;
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
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf kitty.enable {
        programs.kitty.enable = true;
    };
}
