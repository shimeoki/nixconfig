let
    indent = 4;
    columns = 80;
in
{
    config = {
        programs.nixvim.opts = {
            tabstop = indent;
            softtabstop = indent;
            shiftwidth = indent;
            expandtab = true;

            number = true;
            relativenumber = true;

            textwidth = 0;
            wrapmargin = 0;
            wrap = true;
            linebreak = true;

            colorcolumn = builtins.toString (columns + 1);

            breakindent = true;

            termguicolors = true;

            scrolloff = 4;

            signcolumn = "yes";

            winborder = "solid";

            hlsearch = false;
            incsearch = true;
            ignorecase = true;
            smartcase = true;

            showmode = false;
            showtabline = 0;

            splitright = true;
            splitbelow = true;

            cursorline = true;

            updatetime = 1000;

            shortmess = "ltToOCFsI";
            cpoptions = "aABceF";

            undofile = true;
        };
    };
}
