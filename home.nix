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
    };

    home.stateVersion = "25.05";
}
