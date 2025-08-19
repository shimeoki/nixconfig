{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.opts;
in
{
    options.shimeoki.nixvim.opts = with lib; {
        indent = mkOption {
            type = types.int;
            default = 4;
        };
        width = mkOption {
            type = types.int;
            default = 80;
        };
    };

    config = {
        programs.nixvim.opts = {
            tabstop = cfg.indent;
            softtabstop = cfg.indent;
            shiftwidth = cfg.indent;
            expandtab = true;

            number = true;
            relativenumber = true;

            textwidth = 0;
            wrapmargin = 0;
            wrap = true;
            linebreak = true;

            colorcolumn = builtins.toString (cfg.width + 1);

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
