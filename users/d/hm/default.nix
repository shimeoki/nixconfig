let
    username = "d";
in
{
    imports = [
        ./aliases.nix
        ./git.nix
        ./syncthing.nix
        ./waybar.nix
    ];

    home = {
        inherit username;
        homeDirectory = "/home/${username}";
    };

    shimeoki = {
        enable = true;
        nh.flake = "/home/${username}/nixconfig";
    };

    # note: bash is the default shell and
    # works without this, but other things
    # that are reliant on bash - don't.
    # for example: GPG_TTY environment variable
    programs.bash.enable = true;

    home.stateVersion = "25.05";
}
