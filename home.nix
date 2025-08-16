{
    config,
    pkgs,
    nixvim,
    zen-browser,
    ...
}:
{
    imports = [
        nixvim.homeModules.nixvim
        zen-browser.homeModules.twilight
    ];

    home.username = "d";
    home.homeDirectory = "/home/d";
    programs.home-manager.enable = true;

    programs.gpg.enable = true;
    services.gpg-agent = {
        enable = true;
        pinentry.package = pkgs.pinentry-curses;
    };

    programs.ssh.enable = true;
    services.ssh-agent.enable = true;

    # note: bash is the default shell and
    # works without this, but other things
    # that are reliant on bash - don't.
    # for example: GPG_TTY environment variable
    programs.bash.enable = true;

    # note: author specific
    programs.git = {
        enable = true;
        userName = "shimeoki";
        userEmail = "shimeoki@gmail.com";
        signing = {
            key = "2B092E2DCA05866B";
            signByDefault = true;
        };
    };

    programs.niri.settings = {
        layout = {
            default-column-width = {
                proportion = 0.5;
            };

            preset-column-widths = [
                { proportion = 0.5; }
                { proportion = 1.0; }
                { proportion = 0.3; }
            ];
        };

        prefer-no-csd = true;

        binds = with config.lib.niri.actions; {
            "Mod+Shift+Slash".action = show-hotkey-overlay;

            "Mod+Return".action = spawn "kitty";
            "Mod+D".action = spawn "fuzzel";

            "Mod+BackSpace".action = close-window;

            "Mod+R".action = switch-preset-column-width;
            "Mod+Shift+R".action = switch-preset-window-height;
            "Mod+Ctrl+R".action = reset-window-height;

            "Mod+Shift+E".action = quit;
        };
    };

    programs.zen-browser = {
        enable = true;
    };

    programs.fuzzel = {
        enable = true;
    };

    services.dunst = {
        enable = true;
    };

    programs.kitty = {
        enable = true;
    };

    programs.nh = {
        enable = true;
        flake = "/home/d/nixconfig"; # fix: hardcoded path
    };

    programs.nixvim = {
        enable = true;
        defaultEditor = true;
        opts =
            let
                indent = 4;
                columns = 80;
            in
            {
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
        globals = {
            mapleader = " ";
            maplocalleader = " ";
        };
        clipboard.register = "unnamedplus";
        diagnostic.settings = {
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
                # todo: dry
                text = {
                    "__rawKey__vim.diagnostic.severity.ERROR" = "󰅚 ";
                    "__rawKey__vim.diagnostic.severity.WARN" = "󰀪 ";
                    "__rawKey__vim.diagnostic.severity.HINT" = "󰌶 ";
                    "__rawKey__vim.diagnostic.severity.INFO" = " ";
                };
                numhl = {
                    "__rawKey__vim.diagnostic.severity.ERROR" = "DiagnosticSignError";
                    "__rawKey__vim.diagnostic.severity.WARN" = "DiagnosticSignWarn";
                    "__rawKey__vim.diagnostic.severity.HINT" = "DiagnosticSignHint";
                    "__rawKey__vim.diagnostic.severity.INFO" = "DiagnosticSignInfo";
                };
                texthl = {
                    "__rawKey__vim.diagnostic.severity.ERROR" = "DiagnosticSignError";
                    "__rawKey__vim.diagnostic.severity.WARN" = "DiagnosticSignWarn";
                    "__rawKey__vim.diagnostic.severity.HINT" = "DiagnosticSignHint";
                    "__rawKey__vim.diagnostic.severity.INFO" = "DiagnosticSignInfo";
                };
            };
        };
        plugins.lualine = {
            enable = true;
            settings =
                let
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
        plugins.treesitter = {
            # todo: use main branch
            enable = true;
            settings = {
                highlight = {
                    enable = true;
                    additional_vim_regex_highlighting = false;
                };
            };
            languageRegister = {
                css = "gtkcss";
                bash = [
                    "sh"
                    "zsh"
                ];
            };
        };
        plugins.luasnip = {
            # todo: virtual text and snippets
            enable = true;
            settings = {
                region_check_events = [ "InsertEnter" ];
                delete_check_events = [
                    "InsertLeave"
                    "TextChanged"
                ];
            };
        };
        plugins.blink-cmp = {
            enable = true;
            settings = {
                signature.enabled = false;
                snippets.preset = "luasnip";
                sources.default = [
                    "lsp"
                    "snippets"
                    "path"
                    "buffer"
                ];
                completion = {
                    keyword.range = "full";
                    list.selection = {
                        preselect = true;
                        auto_insert = false;
                    };
                    ghost_text.enabled = true;
                    documentation = {
                        auto_show = true;
                        auto_show_delay_ms = 0;
                    };
                    trigger = {
                        prefetch_on_insert = true;
                        show_in_snippet = true;
                        show_on_keyword = true;
                        show_on_trigger_character = true;
                    };
                    menu = {
                        max_height = 11;
                        direction_priority = [
                            "n"
                            "s"
                        ];
                        draw = {
                            # todo: item idx
                            columns = [
                                { __unkeyed-1 = "label"; }
                                { __unkeyed-1 = "label_description"; }
                                { __unkeyed-1 = "kind_icon"; }
                                { __unkeyed-1 = "kind"; }
                                { __unkeyed-1 = "source_name"; }
                            ];
                        };
                    };
                };
                cmdline = {
                    keymap.preset = "inherit";
                    completion = {
                        list.selection = {
                            preselect = false;
                            auto_insert = false;
                        };
                        menu.auto_show = true;
                    };
                };
                keymap = {
                    preset = "none";

                    "<enter>" = [
                        "accept"
                        "snippet_forward"
                        "fallback"
                    ];
                    "<tab>" = [
                        "accept"
                        "snippet_forward"
                        "fallback"
                    ];

                    "<c-s>" = [
                        "show"
                        "hide"
                        "fallback_to_mappings"
                    ];
                    # todo: other show binds

                    "<c-j>" = [
                        "select_next"
                        "fallback_to_mappings"
                    ];
                    "<c-k>" = [
                        "select_prev"
                        "fallback_to_mappings"
                    ];

                    "<c-h>" = [
                        "snippet_backward"
                        "fallback_to_mappings"
                    ];
                    "<c-l>" = [
                        "snippet_forward"
                        "fallback_to_mappings"
                    ];

                    "<c-d>" = [
                        "scroll_documentation_down"
                        "fallback"
                    ];
                    "<c-u>" = [
                        "scroll_documentation_up"
                        "fallback"
                    ];

                    "<c-t>" = [
                        "show_signature"
                        "hide_signature"
                        "fallback"
                    ];
                    "<c-i>" = [
                        "show_documentation"
                        "hide_documentation"
                        "fallback"
                    ];

                    # todo: index binds
                };
                fuzzy.sorts = [
                    "score"
                    "sort_text"
                ]; # todo: exact and source sort
            };
        };
        plugins.notify = {
            enable = true;
            settings.fps = 60; # note: author specific
        };
        plugins.noice = {
            enable = true;
            settings = {
                routes = [
                    {
                        # hide search virtual text
                        opts.skip = true;
                        filter = {
                            event = "msg_show";
                            kind = "search_count";
                        };
                    }
                    {
                        # hide written messages
                        opts.skip = true;
                        filter = {
                            event = "msg_show";
                            kind = "";
                            find = "written";
                        };
                    }
                ];
                lsp.override = {
                    "vim.lsp.util.convert_input_to_markdown_lines" = true;
                    "vim.lsp.util.stylize_markdown" = true;
                };
                cmdline.format.input.view = "cmdline_popup"; # don't force a border
                views = {
                    popup = {
                        border = {
                            style = "none";
                            padding = [
                                1
                                1
                            ];
                        };
                        filter_options = [ ];
                    };
                    cmdline_popup = {
                        border = {
                            style = "none";
                            padding = [
                                1
                                1
                            ];
                        };
                        filter_options = [ ];
                        win_options.winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder";
                    };
                    notify.replace = true;
                    hover = {
                        border = {
                            style = "none";
                            padding = [
                                1
                                1
                            ];
                        };
                        filter_options = [ ];
                        position = {
                            row = 2;
                            col = 0;
                        };
                    };
                    confirm = {
                        border = {
                            style = "none";
                            padding = [
                                1
                                1
                            ];
                        };
                        filter_options = [ ];
                    };
                };
            };
        };
        plugins.lspconfig = {
            enable = true;
        };
        lsp.inlayHints.enable = true;
        dependencies = {
            go.enable = true;
            yazi.enable = true;
            ripgrep.enable = true;
        };
        lsp.servers = {
            lua_ls = {
                enable = true;
                settings = {
                    # todo: on_init function
                    settings.Lua = {
                        runtime = {
                            version = "LuaJIT";
                        };
                        diagnostics = {
                            globals = [
                                "vim"
                                "require"
                            ];
                        };
                        telemetry = {
                            enable = false;
                        };
                        format = {
                            enable = false;
                        };
                        hint = {
                            enable = true;
                            arrayIndex = "Auto";
                            await = true;
                            paramName = "Literal";
                            paramType = true;
                            semicolon = "SameLine";
                            setType = true;
                        };
                    };
                };
            };
            jedi_language_server = {
                enable = true;
            };
            # fix: imports, but doesn't launch
            ruff = {
                enable = true;
                settings = {
                    init_options.settings = {
                        lineLength = 80;
                        lint = {
                            select = [
                                "E4"
                                "E7"
                                "E9"
                                "F"
                            ];
                        };
                    };
                    on_attach = ''
                        -- disable hover for ruff
                        client.server_capabilities.hoverProvider = false
                    '';
                };
            };
            bashls = {
                enable = true;
                settings = {
                    filetypes = [
                        "sh"
                        "zsh"
                        "bash"
                    ];
                };
            };
            clangd = {
                enable = true;
            };
            nushell = {
                enable = true;
            };
            cssls = {
                enable = true;
            };
            texlab = {
                enable = true;
            };
            hyprls = {
                enable = true;
            };
            gopls = {
                enable = true;
                settings.gopls = {
                    hints = {
                        rangeVariableTypes = true;
                        parameterNames = true;
                        constantValues = true;
                        assignVariableTypes = true;
                        compositeLiteralFields = true;
                        compositeLiteralTypes = true;
                        functionTypeParameters = true;
                    };
                };
            };
            dockerls = {
                enable = true;
            };
            marksman = {
                enable = true;
            };
            nixd = {
                enable = true;
            };
        };
        plugins.yazi = {
            enable = true;
            settings = {
                floating_window_scaling_factor = 1.0;
                open_for_directories = true;
                keymaps.show_help = "<f1>";
            };
        };
        plugins.conform-nvim = {
            enable = true;
            settings = {
                format_on_save = ''
                    function(bufnr)
                        if vim.g.disable_format or vim.b[bufnr].disable_format then
                            return
                        end

                        return { timeout_ms = 500, lsp_format = "fallback" }
                    end
                '';
                formatters_by_ft = {
                    nix = [ "nixfmt" ];
                };
                formatters = {
                    nixfmt = {
                        append_args = [
                            "--width=80"
                            "--indent=4"
                        ];
                    };
                };
            };
        };
        plugins.lint = {
            enable = true;
            autoCmd = {
                callback.__raw = ''
                    function()
                        require("lint").try_lint()
                    end
                '';
                event = [
                    "BufEnter"
                    "BufWritePost"
                    "InsertLeave"
                ];
            };
            lintersByFt = {
                nix = [ "statix" ];
            };
        };
        plugins.nvim-autopairs = {
            enable = true;
        };
        plugins.indent-blankline = {
            enable = true;
        };
        plugins.telescope = {
            enable = true;
            extensions = {
                fzf-native = {
                    enable = true;
                    settings = {
                        fuzzy = true;
                        override_generic_sorter = true;
                        override_file_sorter = true;
                        case_mode = "smart_case";
                    };
                };
                ui-select = {
                    enable = true;
                    settings.__raw = ''
                        { require("telescope.themes").get_dropdown() }
                    '';
                };
            };
            settings = {
                defaults = {
                    layout_strategy = "flex";
                    layout_config =
                        let
                            preview_width = 80;
                            preview_cutoff = preview_width + preview_width / 2;
                        in
                        {
                            scroll_speed = 4;
                            horizontal = {
                                anchor = "CENTER";

                                height.padding = 0;
                                width.padding = 0;

                                preview_width = preview_width;
                                preview_cutoff = preview_cutoff;

                                prompt_position = "top";
                                mirror = false;
                            };
                            vertical = {
                                anchor = "CENTER";

                                height.padding = 0;
                                width.padding = 0;

                                prompt_position = "top";
                                mirror = true;
                            };
                            flex = {
                                flip_columns = preview_cutoff;
                            };
                        };
                    sorting_strategy = "ascending";
                    mappings =
                        let
                            keys = {
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
                            i = keys;
                            n = keys;
                        };
                    # todo: vimgrep arguments
                    wrap_results = true;
                    prompt_prefix = "";
                    selection_caret = " ";
                    entry_prefix = " ";
                    border = true;
                    dynamic_preview_title = true;
                    results_title = false;
                };
                pickers = {
                    find_files = {
                        find_command = [
                            "rg"
                            "--files"
                            "--hidden"
                            "--glob"
                            "!**/.git/*"
                        ];
                    };
                    # todo: mappings for buffers
                };
            };
        };
        plugins.web-devicons = {
            enable = true;
        };
        extraPackages = with pkgs; [
            nixfmt
            statix
        ];
        keymaps =
            let
                modes = [
                    "n"
                    "v"
                ];
            in
            [
                {
                    key = "<space>";
                    action = "<nop>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><c-d>";
                    action = ''"_d'';
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>@";
                    action = "<cmd>cd %:p:h<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>u";
                    action = "<cmd>w<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>U";
                    action = "<cmd>wall<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>x";
                    action = "<cmd>wqall<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>h";
                    action = "<cmd>wincmd h<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>j";
                    action = "<cmd>wincmd j<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>k";
                    action = "<cmd>wincmd k<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>l";
                    action = "<cmd>wincmd l<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>H";
                    action = "<cmd>wincmd H<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>J";
                    action = "<cmd>wincmd J<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>K";
                    action = "<cmd>wincmd K<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>L";
                    action = "<cmd>wincmd L<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>,";
                    action = "<cmd>bnext<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>.";
                    action = "<cmd>bprevious<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><c-h>";
                    action = "<cmd>4wincmd <<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><c-j>";
                    action = "<cmd>4wincmd -<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><c-k>";
                    action = "<cmd>4wincmd +<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><c-l>";
                    action = "<cmd>4wincmd ><cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>'";
                    action = "<cmd>vsplit<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>;";
                    action = "<cmd>split<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = ''<leader>"'';
                    action = "<cmd>vnew<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>:";
                    action = "<cmd>new<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><enter>";
                    action = "<cmd>vsplit<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><s-enter>";
                    action = "<cmd>vnew<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><bs>";
                    action = "<cmd>quit<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><s-bs>";
                    action = "<cmd>only<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><c-bs>";
                    action = "<cmd>bdelete<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>[";
                    action = "<cmd>-wincmd w<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>]";
                    action = "<cmd>+wincmd w<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>{";
                    action = "<cmd>wincmd R<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>}";
                    action = "<cmd>wincmd r<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>i";
                    action.__raw = ''
                        function()
                            vim.lsp.buf.hover()
                        end
                    '';
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>I";
                    action.__raw = ''
                        function()
                            vim.lsp.buf.signature_help()
                        end
                    '';
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><c-i>";
                    action.__raw = ''
                        function()
                            local hints = vim.lsp.inlay_hint
                            hints.enable(not hints.is_enabled())
                        end
                    '';
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>a";
                    action.__raw = ''
                        function()
                            vim.lsp.buf.code_action()
                        end
                    '';
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>N";
                    action.__raw = ''
                        function()
                            vim.lsp.buf.rename()
                        end
                    '';
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>c";
                    action.__raw = ''
                        function()
                            vim.api.nvim_input("gcc")
                        end
                    '';
                    options.silent = true;
                    mode = [ "n" ];
                }
                {
                    key = "<leader>c";
                    action.__raw = ''
                        function()
                            vim.api.nvim_input("gc")
                        end
                    '';
                    options.silent = true;
                    mode = [ "v" ];
                }
                {
                    key = "<leader>e";
                    action = "<cmd>Yazi<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>E";
                    action = "<cmd>Yazi cwd<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><c-e>";
                    action = "<cmd>Yazi toggle<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>f";
                    action = "<cmd>Telescope find_files<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>F";
                    action = "<cmd>Telescope live_grep<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>b";
                    action = "<cmd>Telescope buffers<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>B";
                    action = "<cmd>Telescope oldfiles<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>r";
                    action = "<cmd>Telescope commands<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><c-r>";
                    action = "<cmd>Telescope command_history<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>v";
                    action = "<cmd>Telescope registers<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>/";
                    action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>n";
                    action = "<cmd>Telescope lsp_references<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>d";
                    action = "<cmd>Telescope diagnostics bufnr=0<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>D";
                    action = "<cmd>Telescope diagnostics<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>s";
                    action = "<cmd>Telescope lsp_documents_symbols<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>S";
                    action = "<cmd>Telescope lsp_workspace_symbols<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>t";
                    action = "<cmd>Telescope lsp_definitions<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>T";
                    action = "<cmd>Telescope lsp_implementations<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader><c-t>";
                    action = "<cmd>Telescope lsp_type_definitions<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>g";
                    action = "<cmd>Telescope git_commits<cr>";
                    options.silent = true;
                    mode = modes;
                }
                {
                    key = "<leader>G";
                    action = "<cmd>Telescope git_branches<cr>";
                    options.silent = true;
                    mode = modes;
                }
                # todo: quarto
                {
                    key = "<c-s-l>";
                    action.__raw = ''
                        function()
                            local ls = require("luasnip")
                            return ls.choice_active() and ls.change_choice(1)
                        end
                    '';
                    options.silent = true;
                    mode = [
                        "i"
                        "s"
                    ];
                }
                {
                    key = "<c-s-h>";
                    action.__raw = ''
                        function()
                            local ls = require("luasnip")
                            return ls.choice_active() and ls.change_choice(-1)
                        end
                    '';
                    options.silent = true;
                    mode = [
                        "i"
                        "s"
                    ];
                }
                {
                    key = "<c-bs>";
                    action.__raw = ''
                        function()
                            require("luasnip").unlink_current()
                        end
                    '';
                    options.silent = true;
                    mode = [
                        "i"
                        "s"
                    ];
                }
            ];
    };

    home.stateVersion = "25.05";
}
