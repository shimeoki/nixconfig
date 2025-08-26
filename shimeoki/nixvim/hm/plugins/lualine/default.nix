{
    config,
    lib,
    ...
}:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.lualine;
    position = [
        {
            __unkeyed-1 = "mode";
            fmt = ''
                function(s)
                  string.sub(string.lower(s), 1, 3)
                end
            '';
        }
        { __unkeyed-1 = "location"; }
        {
            __unkeyed-1 = "progress";
            fmt = ''string.lower'';
        }
    ];
    fileinfo = [
        {
            __unkeyed-1 = "fileformat";
            symbols = {
                unix = "lf";
                dos = "crlf";
                mac = "lf";
            };
        }
        {
            __unkeyed-1 = "encoding";
            show_bomb = false;
        }
    ];
    file = [
        {
            __unkeyed-1 = "filename";
            file_status = true;
            newfile_status = true;
            path = 4;
            shorting_target = 40;
            symbols = {
                modified = "~";
                readonly = "=";
                unnamed = "?";
                newfile = "+";
            };
        }
        {
            __unkeyed-1 = "filetype";
            colored = true;
            icon_only = false;
            icon = {
                align = "left";
            };
        }
    ];
    status = [
        {
            __unkeyed-1 = "diagnostics";
            sources = [
                "nvim_lsp"
                "nvim_diagnostic"
            ];
            sections = [
                "error"
                "warn"
                "info"
                "hint"
            ];
            colored = true;
            update_in_insert = false;
            always_visible = false;
        }
    ];
    git = [
        {
            __unkeyed-1 = "diff";
            colored = true;
            symbols = {
                added = "+";
                modified = "~";
                removed = "-";
            };
        }
        {
            __unkeyed-1 = "branch";
            icon = "@";
        }
    ];
in
{
    imports = [
        ./lazy-load.nix
    ];

    options.shimeoki.nixvim.plugins.lualine = {
        enable = lib.mkEnableOption "lualine" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.lualine = {
            enable = true;
            settings = {
                options = {
                    component_separators = "";
                    section_separators = "";
                };
                sections = {
                    lualine_a = position;
                    lualine_b = fileinfo;
                    lualine_c = file;
                    lualine_x = status;
                    lualine_y = git;
                    lualine_z.__raw = ''{}''; # todo: noice macro display
                };
                inactive_sections = {
                    lualine_c = file;
                    lualine_x = status;
                };
            };
        };
    };
}
