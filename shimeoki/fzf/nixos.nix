{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.fzf;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.fzf = {
        enable = lib.mkEnableOption "fzf" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
