{
    config,
    lib,
    ...
}:
let
    inherit (config.shimeoki) nixvim;
in
{
    imports = [
        ./base16
    ];

    options.shimeoki.nixvim.colorschemes = {
        enable = lib.mkEnableOption "colorschemes" // {
            default = nixvim.enable;
        };
    };
}
