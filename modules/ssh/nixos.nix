{
    config,
    lib,
    ...
}:
let
    cfg = config.shimeoki.ssh;
in
{
    options.shimeoki.ssh = {
        enable = lib.mkEnableOption "ssh";
    };

    config = lib.mkIf cfg.enable {
        # todo: check for home manager
        home-manager.sharedModules = [ ./home.nix ];
    };
}
