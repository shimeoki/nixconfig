{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
    inherit (nixvim) lspconfig languages plugins;
    inherit (languages) python;
    inherit (plugins) lsp;
in
{
    config = lib.mkIf (python.enable && lsp.enable) {
        programs.nixvim = {
            # TODO: based pyright
            lsp.servers = {
                ruff.enable = true;
            };

            extraFiles = lib.mkMerge [
                (lspconfig "ruff")
            ];
        };
    };
}
