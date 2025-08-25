{
    # todo: users/ configuration

    # custom modules
    shimeoki = {
        enable = true;

        waybar = {
            keyboard-state.enable = false;
            cava.enable = false;
            mpd.enable = false;
        };

        git.delta.enable = false;
    };

    home.username = "d";
    home.homeDirectory = "/home/d";
    programs.home-manager.enable = true;

    home = {
        shellAliases = {
            ctl = "systemctl";
            sctl = "sudo systemctl --system";
            uctl = "systemctl --user";
        };
    };

    # note: bash is the default shell and
    # works without this, but other things
    # that are reliant on bash - don't.
    # for example: GPG_TTY environment variable
    programs.bash.enable = true;

    home.stateVersion = "25.05";
}
