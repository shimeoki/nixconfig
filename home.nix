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
        dependencies = {
            go.enable = true;
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
            settings = {
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
        plugins.web-devicons = {
            enable = true;
        };
        extraPackages = with pkgs; [
            nixfmt
            statix
        ];
    };

    home.stateVersion = "25.05";
}
