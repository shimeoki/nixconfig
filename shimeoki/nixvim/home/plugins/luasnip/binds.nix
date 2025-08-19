{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.plugins.luasnip;
    bind =
        keys: action:
        config.shimeoki.nixvim.keymap.bind {
            inherit keys action;
            mod = "";
            lua = true;
            modes = [
                "i"
                "s"
            ];
        };
in
{
    config = lib.mkIf cfg.enable {
        programs.nixvim.keymaps = [
            (bind "<c-s-l>" ''
                function()
                    local ls = require("luasnip")
                    return ls.choice_active() and ls.change_choice(1)
                end
            '')

            (bind "<c-s-h>" ''
                function()
                    local ls = require("luasnip")
                    return ls.choice_active() and ls.change_choice(-1)
                end
            '')

            (bind "<c-bs>" ''
                function()
                    require("luasnip").unlink_current()
                end
            '')
        ];
    };
}
