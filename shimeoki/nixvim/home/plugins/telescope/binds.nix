{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.plugins.telescope;
    bind =
        keys: action:
        config.shimeoki.nixvim.keymap.bind {
            inherit keys;
            action = "Telescope ${action}";
        };
in
{
    config = lib.mkIf cfg.enable {
        programs.nixvim.keymaps = [
            (bind "f" "find_files")
            (bind "F" "live_grep")
            (bind "b" "buffers")
            (bind "B" "oldfiles")
            (bind "r" "commands")
            (bind "<c-r>" "command_history")
            (bind "v" "registers")
            (bind "/" "current_buffer_fuzzy_find")
            (bind "n" "lsp_references")
            (bind "d" "diagnostics bufnr=0")
            (bind "D" "diagnostics")
            (bind "s" "lsp_document_symbols")
            (bind "S" "lsp_workspace_symbols")
            (bind "t" "lsp_definitions")
            (bind "T" "lsp_implementations")
            (bind "<c-t>" "lsp_type_definitions")
            (bind "g" "git_commits")
            (bind "G" "git_branches")
        ];
    };
}
