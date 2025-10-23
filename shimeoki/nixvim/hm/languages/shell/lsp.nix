{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
    inherit (nixvim) lspconfig languages plugins;
    inherit (languages) shell;
    inherit (plugins) lsp;
in
{
    config = lib.mkIf (shell.enable && lsp.enable) {
        programs.nixvim = {
            lsp.servers = {
                bashls.enable = true;
            };

            extraFiles = lib.mkMerge [
                (lspconfig "bashls")
            ];
        };
    };
}
