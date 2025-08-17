{
    config,
    options,
    lib,
    ...
}:
let
    cfg = config.shimeoki.git;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.git = {
        enable = lib.mkEnableOption "git" // {
            default = true;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
