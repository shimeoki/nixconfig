{ config, pkgs, nixvim, ... }:
{
  imports = [
    nixvim.homeModules.nixvim
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
      in {
        options = {
          component_separators = "";
          section_separators = "";
        };
        sections = {
          lualine_a = position;
          lualine_b = fileinfo;
        };
        inactive_sections = {

        };
      };
    };
  };

  home.packages = with pkgs; [
  ];

  home.stateVersion = "25.05";
}
