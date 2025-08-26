{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) lazygit;
in
{
    imports = [
        ./settings.nix
        ./aliases.nix
    ];

    options.shimeoki.lazygit = {
        enable = lib.mkEnableOption "lazygit" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf lazygit.enable {
        programs.lazygit.enable = true;
    };
}
