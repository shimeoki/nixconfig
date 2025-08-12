{ config, pkgs, nixvim, zen-browser, ... }:
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
      default-column-width = { proportion = 0.5; };

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

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    opts = let
      indent = 4;
      columns = 80;
    in {
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
    plugins.lualine = {
      enable = true;
      settings = let
        position = [
          { __unkeyed-1 = "mode"; fmt = ''
            function(s)
              string.sub(string.lower(s), 1, 3)
            end
          ''; }
          { __unkeyed-1 = "location"; }
          { __unkeyed-1 = "progress"; fmt = ''string.lower''; }
        ];
        fileinfo = [
          {
            __unkeyed-1 = "fileformat";
            symbols = { unix = "lf"; dos = "crlf"; mac = "lf"; };
          }
          { __unkeyed-1 = "encoding"; show_bomb = false; }
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
            icon = { align = "left"; };
          }
        ];
        status = [
          {
            __unkeyed-1 = "diagnostics";
            sources = [ "nvim_lsp" "nvim_diagnostic" ];
            sections = [ "error" "warn" "info" "hint" ];
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
          { __unkeyed-1 = "branch"; icon = "@"; }
        ];
      in {
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
    plugins.treesitter = { # todo: use main branch
      enable = true;
      settings = {
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = false;
        };
      };
      languageRegister = {
        css = "gtkcss";
        bash = [ "sh" "zsh" ];
      };
    };
    plugins.lspconfig = {
      enable = true;
    };
    lsp.inlayHints.enable = true;
    lsp.servers = {
      lua_ls = {
        enable = true;
        settings = {
          # todo: on_init function
          settings.Lua = {
            runtime = { version = "LuaJIT"; };
            diagnostics = { globals = [ "vim" "require" ]; };
            telemetry = { enable = false; };
            format = { enable = false; };
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
            lint = { select = [ "E4" "E7" "E9" "F" ]; };
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
          filetypes = [ "sh" "zsh" "bash" ];
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
  };

  home.packages = with pkgs; [
    go # required by gopls. probably a bug
  ];

  home.stateVersion = "25.05";
}
