{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.languages.web;
    inherit (config.shimeoki.nixvim.plugins) lsp;
in
{
    config = lib.mkIf (cfg.enable && lsp.enable) {
        programs.nixvim.lsp.servers = {
            cssls.enable = true;

            ts_ls = {
                enable = true;
                settings = {
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

            # TODO: denols setup
            # TODO: svelte setup
        };
    };
}
