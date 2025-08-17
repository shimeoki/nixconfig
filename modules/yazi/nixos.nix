{
    config,
    options,
    lib,
    ...
}:
let
    cfg = config.shimeoki.yazi;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.yazi = {
        enable = lib.mkEnableOption "yazi" // {
            default = true;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
