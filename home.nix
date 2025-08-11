{ config, pkgs, zen-browser, ... }:
{
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

  home.packages = with pkgs; [
    neovim
  ];

  home.stateVersion = "25.05";
}
