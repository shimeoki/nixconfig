{
    pkgs,
    ...
}:
{
    stylix.targets = {
        kitty = {
            variant256Colors = true;
        };
        nixvim = {
            plugin = "base16-nvim";
            transparentBackground = {
                main = true;
                numberLine = true;
                signColumn = true;
            };
        };
        # todo: use in zen-browser module
        zen-browser = {
            profileNames = [ "main" ];
        };
    };

    # enable custom modules
    shimeoki.enable = true;

    home.username = "d";
    home.homeDirectory = "/home/d";
    programs.home-manager.enable = true;

    # note: bash is the default shell and
    # works without this, but other things
    # that are reliant on bash - don't.
    # for example: GPG_TTY environment variable
    programs.bash.enable = true;

    programs.fuzzel = {
        enable = true;
    };

    services.dunst = {
        enable = true;
    };

    programs.nixvim = {
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
            ripgrep.enable = true;
            nodejs.enable = true;
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
            fd
        ];
        keymaps = [
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
