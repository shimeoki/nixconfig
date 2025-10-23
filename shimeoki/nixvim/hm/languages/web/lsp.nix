{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
    inherit (nixvim) lspconfig languages plugins;
    inherit (languages) web;
    inherit (plugins) lsp;
in
{
    config = lib.mkIf (web.enable && lsp.enable) {
        programs.nixvim = {
            lsp.servers = {
                # keep-sorted start
                cssls.enable = true;
                denols.enable = true;
                svelte.enable = true;
                # keep-sorted end

                # TODO: full setup
                ts_ls = {
                    enable = true;
                    config = {
                        cmd = [
                            "typescript-language-server"
                            "--stdio"
                        ];
                        workspace_required = true;
                        filetypes = [
                            "javascript"
                            "javascriptreact"
                            "typescript"
                            "typescriptreact"
                            "vue" # TODO: vue setup
                        ];
                        root_markers = [
                            "package-lock.json"
                            "yarn.lock"
                            "pnpm-lock.yaml"
                            "bun.lockb"
                            "bun.lock"
                        ];
                    };
                };
            };

            extraFiles = lib.mkMerge [
                # keep-sorted start
                (lspconfig "cssls")
                (lspconfig "denols")
                (lspconfig "svelte")
                # keep-sorted end
            ];
        };
    };
}
