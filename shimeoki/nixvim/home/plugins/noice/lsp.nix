{
    config = {
        programs.nixvim.plugins.noice.settings.lsp.override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
        };
    };
}
