{ config, pkgs, ... }:
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

  home.packages = with pkgs; [
    neovim
  ];

  home.stateVersion = "25.05";
}
