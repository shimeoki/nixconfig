{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki)
        rmpc
        mpd
        kitty
        dotfiles
        ;

    theme = "rmpc/themes/infinite.ron";
in
{
    options.shimeoki.rmpc = {
        enable = lib.mkEnableOption "rmpc" // {
            default = shimeoki.enable;
        };
    };

    # FIXME: for cava integration mpd needs to be configured
    # to output audio in the corresponding fifo file

    config = lib.mkIf (rmpc.enable && mpd.enable && kitty.enable) {
        home.packages = with pkgs; [
            cava # needed for visualization
            libnotify # needed for rmpc-notify.sh script
        ];

        programs.rmpc = {
            enable = true;
            config = builtins.readFile (dotfiles.config "rmpc/config.ron");
        };

        xdg.configFile.${theme}.source = dotfiles.config theme;
    };
}
