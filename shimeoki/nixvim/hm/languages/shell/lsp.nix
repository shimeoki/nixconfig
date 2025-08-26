{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.languages.shell;
    inherit (config.shimeoki.nixvim.plugins) lsp;
in
{
    config = lib.mkIf (cfg.enable && lsp.enable) {
        programs.nixvim.lsp.servers = {
            bashls = {
                enable = true;
                settings = {
                    filetypes = [
                        "sh"
                        "zsh"
                        "bash"
                    ];
                };
            };
        };
    };
}
