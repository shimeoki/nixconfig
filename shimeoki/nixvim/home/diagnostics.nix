{ lib, ... }:
let
    key = type: "__rawKey__vim.diagnostic.severity.${lib.toUpper type}";
    sign = type: {
        "${key type}" = "DiagnosticSign${lib.toSentenceCase type}";
    };
    signs = lib.mkMerge [
        (sign "error")
        (sign "warn")
        (sign "hint")
        (sign "info")
    ];
in
{
    config = {
        programs.nixvim.diagnostic.settings = {
            underline = true;
            severity_sort = true;
            update_in_insert = false;
            float.source = true;
            virtual_text = {
                source = true;
                spacing = 0;
                prefix = "";
                hl_mode = "replace";
                virt_text_pos = "eol";
            };
            signs = {
                text = {
                    "${key "error"}" = "󰅚 ";
                    "${key "warn"}" = "󰀪 ";
                    "${key "hint"}" = "󰌶 ";
                    "${key "info"}" = " ";
                };
                numhl = signs;
                texthl = signs;
            };
        };
    };
}
