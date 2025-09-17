{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.languages.web;
    inherit (config.shimeoki.nixvim.plugins) lsp;
in
{
    config = lib.mkIf (cfg.enable && lsp.enable) {
        programs.nixvim.lsp.servers = {
            cssls.enable = true;
            # TODO: tsls setup
            # TODO: denols setup
            # TODO: svelte setup
        };
    };
}
