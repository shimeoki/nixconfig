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
        ./lualine.nix
        ./telescope
        ./yazi
        ./treesitter
    ];

    options.shimeoki.nixvim.plugins = {
        enable = lib.mkEnableOption "plugins" // {
            default = nixvim.enable;
        };
    };
}
