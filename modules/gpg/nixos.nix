{
    config,
    lib,
    ...
}:
let
    cfg = config.shimeoki.gpg;
in
{
    options.shimeoki.gpg = {
        enable = lib.mkEnableOption "gpg";
    };

    config = lib.mkIf cfg.enable {
        # todo: check for home manager
        home-manager.sharedModules = [ ./home.nix ];
    };
}
