{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) mpd dotfiles;
in
{
    options.shimeoki.mpd = {
        enable = lib.mkEnableOption "mpd" // {
            default = shimeoki.enable;
        };
    };

    # FIXME: music directory is hardcoded and defined in the config
    # FIXME: mpd/playlists directory needs to be created manually

    config = lib.mkIf mpd.enable {
        services.mpd = {
            enable = true;
            musicDirectory = "${config.home.homeDirectory}/Music";
            dbFile = null;
            extraConfig = builtins.readFile (dotfiles.config "mpd/mpd.conf");
        };
    };
}
