{
    imports = [
        ./aliases.nix
        ./shimeoki.nix
    ];

    home = {
        username = "d";
        homeDirectory = "/home/d";
    };

    # note: bash is the default shell and
    # works without this, but other things
    # that are reliant on bash - don't.
    # for example: GPG_TTY environment variable
    programs.bash.enable = true;

    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
}
