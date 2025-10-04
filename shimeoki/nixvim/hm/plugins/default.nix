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
        ./autopairs
        ./blink
        ./conform
        ./friendly-snippets
        ./gitsigns
        ./indent-blankline
        ./jdtls
        ./lint
        ./lsp
        ./lualine
        ./luasnip
        ./lz-n
        ./noice
        ./notify
        ./telescope
        ./treesitter
        ./yazi
    ];

    options.shimeoki.nixvim.plugins = {
        enable = lib.mkEnableOption "plugins" // {
            default = nixvim.enable;
        };
    };
}
