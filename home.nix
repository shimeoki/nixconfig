{
    # todo: users/ configuration

    stylix.targets = {
        # todo: use in kitty module
        kitty = {
            variant256Colors = true;
        };
        # todo: use in nixvim module
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
        # todo: use in waybar module
        waybar = {
            enableLeftBackColors = true;
            enableCenterBackColors = true;
            enableRightBackColors = true;
        };
    };

    # custom modules
    shimeoki = {
        enable = true;

        waybar = {
            keyboard-state.enable = false;
            cava.enable = false;
            mpd.enable = false;
        };
    };

    home.username = "d";
    home.homeDirectory = "/home/d";
    programs.home-manager.enable = true;

    # note: bash is the default shell and
    # works without this, but other things
    # that are reliant on bash - don't.
    # for example: GPG_TTY environment variable
    programs.bash.enable = true;

    home.stateVersion = "25.05";
}
