{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) btop;
in
{
    imports = [
        ./aliases.nix
    ];

    options.shimeoki.btop = {
        enable = lib.mkEnableOption "btop" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf btop.enable {
        programs.btop = {
            enable = true;
        };
    };
}
