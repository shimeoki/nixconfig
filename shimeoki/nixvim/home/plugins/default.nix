{
    config,
    lib,
    ...
}:
let
    inherit (config.shimeoki) nixvim;
in
{
    # todo: quarto

    imports = [
        ./lualine.nix
        ./telescope
        ./yazi
        ./treesitter
        ./luasnip
    ];

    options.shimeoki.nixvim.plugins = {
        enable = lib.mkEnableOption "plugins" // {
            default = nixvim.enable;
        };
    };
}
