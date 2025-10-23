{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
    inherit (nixvim) lspconfig languages plugins;
    inherit (languages) go;
    inherit (plugins) lsp;
in
{
    config = lib.mkIf (go.enable && lsp.enable) {
        programs.nixvim = {
            lsp.servers = {
                gopls.enable = true;
            };

            extraFiles = lib.mkMerge [
                (lspconfig "gopls")
            ];
        };
    };
}
