{ config, ... }:
{
    shimeoki = {
        enable = true;

        waybar = {
            keyboard-state.enable = false;
            cava.enable = false;
            mpd.enable = false;
        };

        git = {
            delta.enable = false;

            name = "shimeoki";
            email = "shimeoki@gmail.com";
            signing.key = "2B092E2DCA05866B";
        };

        nh.flake = "${config.home.homeDirectory}/nixconfig";

        syncthing.presets = {
            enable = true;

            pictures.enable = true;
            password-store.enable = true;
        };
    };
}
