{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.git;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.git = {
        enable = lib.mkEnableOption "git" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
