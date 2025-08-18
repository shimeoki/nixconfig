{ config, ... }:
let
    bindRaw = config.shimeoki.nixvim.keymap.bind;
    bind = keys: action: bindRaw { inherit keys action; };
    bindLua =
        keys: action:
        bindRaw {
            inherit keys action;
            lua = true;
        };
in
{
    config = {
        programs.nixvim.keymaps = [
            (bind "@" "cd %:p:h")

            (bind "u" "w")
            (bind "U" "wall")
            (bind "x" "wqall")

            (bind "h" "wincmd h")
            (bind "j" "wincmd j")
            (bind "k" "wincmd k")
            (bind "l" "wincmd l")

            (bind "H" "wincmd H")
            (bind "J" "wincmd J")
            (bind "K" "wincmd K")
            (bind "L" "wincmd L")

            (bind "," "bnext")
            (bind "." "bprevious")

            (bind "<c-h>" "4wincmd <")
            (bind "<c-j>" "4wincmd -")
            (bind "<c-k>" "4wincmd +")
            (bind "<c-l>" "4wincmd >")

            (bind ";" "split")
            (bind "'" "vsplit")

            (bind ":" "new")
            (bind ''"'' "vnew")

            (bind "<enter>" "vsplit")
            (bind "<s-enter>" "vnew")

            (bind "<bs>" "quit")
            (bind "<s-bs>" "only")
            (bind "<c-bs>" "bdelete")

            (bind "[" "-wincmd w")
            (bind "]" "+wincmd w")

            (bind "{" "wincmd R")
            (bind "}" "wincmd r")

            (bindLua "i" ''
                function()
                    vim.lsp.buf.hover()
                end
            '')

            (bindLua "I" ''
                function()
                    vim.lsp.buf.signature_help()
                end
            '')

            (bindLua "<c-i>" ''
                function()
                    local hints = vim.lsp.inlay_hint
                    hints.enable(not hints.is_enabled())
                end
            '')

            (bindLua "a" ''
                function()
                    vim.lsp.buf.code_action()
                end
            '')

            (bindLua "N" ''
                function()
                    vim.lsp.buf.rename()
                end
            '')

            (bindRaw {
                mod = "";
                keys = "<space>";
                cmd = false;
                action = "<nop>";
            })

            (bindRaw {
                keys = "<c-d>";
                cmd = false;
                action = ''"_d'';
            })

            (bindRaw {
                keys = "c";
                lua = true;
                action = ''
                    function()
                        vim.api.nvim_input("gcc")
                    end
                '';
                modes = [ "n" ];
            })

            (bindRaw {
                keys = "c";
                lua = true;
                action = ''
                    function()
                        vim.api.nvim_input("gc")
                    end
                '';
                modes = [ "v" ];
            })
        ];
    };
}
