{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.plugins.telescope;

    bind =
        keys: action:
        config.shimeoki.nixvim.keymap.bind {
            inherit keys;
            action = "Telescope ${action}";
        };

    pickers = [
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

    internal = {
        "<c-j>" = "move_selection_next";
        "<c-k>" = "move_selection_previous";

        "<c-l>" = "cycle_previewers_next";
        "<c-h>" = "cycle_previewers_prev";

        "<c-u>" = false;
        "<c-d>" = false;

        "<c-;>" = "select_horizontal";
        "<c-'>" = "select_vertical";

        "<J>" = "preview_scrolling_down";
        "<K>" = "preview_scrolling_up";
        # todo: layout toggle preview

        "<esc>" = "close";
        "<s-esc>" = {
            __unkeyed-1 = "<esc>";
            type = "command";
        };

        # todo: row indexes
    };
in
{
    # todo: mappings for buffers

    config = lib.mkIf cfg.enable {
        programs.nixvim = {
            keymaps = pickers;
            plugins.telescope.settings.defaults.mappings = {
                i = internal;
                n = internal;
            };
        };
    };
}
