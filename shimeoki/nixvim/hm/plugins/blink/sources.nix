{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.plugins.blink;
in
{
    config = lib.mkIf cfg.enable {
        shimeoki.nixvim.plugins.luasnip.enable = lib.mkForce true;
        programs.nixvim.plugins.blink-cmp.settings = {
            snippets.preset = "luasnip";
            sources.default = [
                "lsp"
                "snippets"
                "path"
                "buffer"
            ];
        };
    };
}
