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

    # todo: module
    programs.fuzzel = {
        enable = true;
    };

    # todo: module
    services.dunst = {
        enable = true;
    };

    home.stateVersion = "25.05";
}
