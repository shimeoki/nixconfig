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
            lsp.servers = {
                # keep-sorted start
                jedi_language_server.enable = true;
                ruff.enable = true;
                # keep-sorted end
            };

            extraFiles = lib.mkMerge [
                # keep-sorted start
                (lspconfig "jedi_language_server")
                (lspconfig "ruff")
                # keep-sorted end
            ];
        };
    };
}
