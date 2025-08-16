{
    config,
    pkgs,
    lib,
    dotfiles,
    nixvim,
    zen-browser,
    ...
}:
{
    imports = [
        nixvim.homeModules.nixvim
        zen-browser.homeModules.twilight
    ];

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
        zen-browser = {
            profileNames = [ "main" ];
        };
    };

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
        extraConfig = {
            init.defaultBranch = "main";
            core = {
                whitespace = "error";
                preloadIndex = true;
            };
            commit.verbose = true;
            merge = {
                conflictStyle = "zdiff3";
                ff = false;
            };
            diff = {
                colorMoved = "default";
                algorithm = "histogram";
                submodule = "log";
                renames = "copies";
            };
            status = {
                branch = true;
                showStash = true;
                submoduleSummary = true;
            };
            submodule.recurse = true;
            transfer = {
                fsckObjects = true;
            };
            fetch = {
                fsckObjects = true;
                prune = true;
            };
            receive = {
                fsckObjects = true;
            };
            log = {
                date = "iso";
                abbrevCommit = true;
            };
            branch.sort = "-commiterdate";
            push = {
                autoSetupRemote = true;
                default = "current";
                followTags = true;
            };
            pull.ff = "only";
            tag.sort = "-taggerdate";
        };
        aliases = {
            ci = "commit";
            reword = "commit --amend";
            st = "status --short";
            sw = "switch";
            new = "switch --create";
            b = "branch";
            del = "branch --delete";
            list = "branch --all";
            hist = "log --graph --oneline --all";
            undo = "reset HEAD~";
            unstage = "reset HEAD";
            m = "merge";
            ff = "merge --ff";
            changes = "diff --cached";
        };
    };

    programs.yazi = {
        enable = true;
        settings = {
            mgr = {
                ratio = [
                    1
                    3
                    3
                ];
                sort_by = "natural";
                sort_dir_first = true;
                sort_translit = true;
                linemode = "none";
                show_symlink = true;
                scrolloff = 5;
            };
            preview = {
                wrap = "yes";
                tab_size = 4;
                max_width = 1280;
                max_height = 720;
            };
            plugin.prepend_fetchers = [
                {
                    id = "git";
                    name = "*";
                    run = "git";
                }
                {
                    id = "git";
                    name = "*/";
                    run = "git";
                }
            ];
            tasks = {
                image_bound = [
                    0
                    0
                ];
            };
        };
        plugins = with pkgs.yaziPlugins; {
            inherit
                git
                ouch
                diff
                chmod
                toggle-pane
                full-border
                ;
        };
        keymap = {
            mgr.prepend_keymap = [
                {
                    on = [
                        "c"
                        "m"
                    ];
                    run = "plugin chmod";
                }
                {
                    on = [ "<C-d>" ];
                    run = "plugin diff";
                }
                {
                    on = [ "!" ];
                    run = ''shell "$SHELL" --block --confirm'';
                }
                # todo: ripdrag
                {
                    on = [
                        "g"
                        "r"
                    ];
                    # todo: ensure that git is installed
                    run = ''shell -- ya emit cd "$(git rev-parse --show-toplevel)"'';
                }
                {
                    on = [ "<C-t>" ];
                    run = "plugin toggle-pane min-preview";
                }
                {
                    on = [ "T" ];
                    run = "plugin toggle-pane max-preview";
                }
                # todo: swww
                {
                    on = [ "C" ];
                    run = "plugin ouch";
                }
            ];
        };
        # fix: just the path doesn't work
        initLua = builtins.readFile "${dotfiles}/root/private_dot_config/yazi/init.lua";
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
        policies = {
            AutofillAddressEnabled = true;
            AutofillCreditCardEnabled = false;
            DisableAppUpdate = true;
            DisableFeedbackCommands = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DontCheckDefaultBrowser = true;
            NoDefaultBookmarks = true;
            OfferToSaveLogins = true;
            EnableTrackingProtection = {
                Value = true;
                Locked = true;
                Cryptomining = true;
                Fingerprinting = true;
            };
        };
        profiles.main = {
            id = 0;
            search = {
                force = true;
                default = "ddg";
                privateDefault = "ddg";
                order = [
                    "ddg"
                    "google"
                ];
                engines = {
                    nixpkgs = {
                        name = "nixpkgs";
                        urls = [
                            {
                                template = "https://search.nixos.org/packages";
                                params = [
                                    {
                                        name = "type";
                                        value = "packages";
                                    }
                                    {
                                        name = "query";
                                        value = "{searchTerms}";
                                    }
                                ];
                                definedAliases = [ "@np" ];
                                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                            }
                        ];
                    };

                    nixwiki = {
                        name = "nixwiki";
                        urls = [
                            {
                                teamplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                            }
                        ];
                        iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
                        definedAliases = [ "@nw" ];
                    };

                    bing.metaData.hidden = true;
                    google.metaData.alias = "@g";
                };
            };
        };
    };

    xdg.mimeApps = {
        enable = true;
        defaultApplications =
            let
                browser = "zen-twilight.desktop";
            in
            {
                "text/html" = browser;
                "text/xml" = browser;
                "application/xhtml+xml" = browser;
                "x-scheme-handler/http" = browser;
                "x-scheme-handler/https" = browser;
                "application/x-xpinstall" = browser;
                "application/pdf" = browser;
                "application/json" = browser;
            };
    };

    programs.fuzzel = {
        enable = true;
    };

    services.dunst = {
        enable = true;
    };

    programs.kitty = {
        enable = true;
        font = {
            # hack: otherwise stylix doesn't work
            # better to specify in stylix config
            package = lib.mkForce pkgs.nerd-fonts.fira-code;
            name = lib.mkForce "FiraCode Nerd Font";
            size = 12;
        };
        settings = {
            kitty_mod = "alt";

            disable_ligatures = "always";

            "modify_font underline_position" = 4;
            "modify_font underline_thickness" = "150%";
            "modify_font strikethrough_position" = -2;

            enabled_layouts = "splits, stack";

            window_resize_step_cells = 2;
            window_resize_step_lines = 2;

            window_border_width = "0px";
            draw_minimal_borders = true;

            window_margin_width = 0;
            single_window_margin_width = 0;

            window_padding_width = "6 9";
            single_window_padding_width = -1;

            placement_strategy = "center";

            inactive_text_alpha = 1.0;

            hide_window_decorations = true;

            tab_bar_edge = "top";
            tab_bar_align = "left";

            tab_bar_margin_width = 0;
            tab_bar_background = "none";

            tab_bar_style = "hidden";
            tab_powerline_style = "slanted";
            tab_separator = "";

            tab_title_template = ''" {fmt.fg.red}[bell_symbol]{activity_symbol}{fmt.fg.tab} {index} {title} {tab.last_focused_progress_percent} "'';

            tab_bar_min_tabs = 2;
            tab_switch_strategy = "previous";

            enable_audio_bell = false;

            cursor_trail = 3;
            cursor_trail_decay = "0.1 0.4";
        };
        keybindings = {
            "kitty_mod+/" = "scroll_line_up";
            "kitty_mod+shift+/" = "scroll_line_down";

            "kitty_mod+[" = "previous_window";
            "kitty_mod+]" = "next_window";

            "kitty_mod+h" = "neighboring_window left";
            "kitty_mod+j" = "neighboring_window bottom";
            "kitty_mod+k" = "neighboring_window top";
            "kitty_mod+l" = "neighboring_window right";

            "kitty_mod+shift+[" = "move_window_backward";
            "kitty_mod+shift+]" = "move_window_forward";

            "kitty_mod+shift+h" = "move_window left";
            "kitty_mod+shift+j" = "move_window bottom";
            "kitty_mod+shift+k" = "move_window top";
            "kitty_mod+shift+l" = "move_window right";

            "kitty_mod+enter" = "new_window_with_cwd";
            "kitty_mod+shift+enter" = "new_window";

            "kitty_mod+backspace" = "close_window";
            "kitty_mod+shift+backspace" = "close_other_windows_in_tab";

            "kitty_mod+r" = "start_resizing_window";

            "kitty_mod+w" = "new_tab_with_cwd";
            "kitty_mod+shift+w" = "new_tab";

            "kitty_mod+q" = "close_tab";
            "kitty_mod+shift+q" = "close_other_tabs_in_os_window";

            "kitty_mod+," = "previous_tab";
            "kitty_mod+." = "next_tab";

            "kitty_mod+shift+," = "move_tab_backward";
            "kitty_mod+shift+." = "move_tab_forward";

            "kitty_mod+1" = "goto_tab 1";
            "kitty_mod+2" = "goto_tab 2";
            "kitty_mod+3" = "goto_tab 3";
            "kitty_mod+4" = "goto_tab 4";
            "kitty_mod+5" = "goto_tab 5";
            "kitty_mod+6" = "goto_tab 6";
            "kitty_mod+7" = "goto_tab 7";
            "kitty_mod+8" = "goto_tab 8";
            "kitty_mod+9" = "goto_tab 9";

            "kitty_mod+b" = "select_tab";

            "kitty_mod+d" = "detach_window";
            "kitty_mod+shift+d" = "detach_tab";

            "kitty_mod+a" = "detach_window ask";
            "kitty_mod+shift+a" = "detach_tab ask";

            "kitty_mod+;" = "launch --location=hsplit --cwd=current";
            "kitty_mod+'" = "launch --location=vsplit --cwd=current";

            "kitty_mod+shift+;" = "launch --location=hsplit";
            "kitty_mod+shift+'" = "launch --location=vsplit";

            "kitty_mod+\\" = "layout_action rotate";
            "kitty_mod+f" = "toggle_layout stack";

            # todo: scrollback
        };
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
            nodejs.enable = true;
            gcc.enable = true;
            tree-sitter.enable = true;
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
            fd
            wl-clipboard
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
