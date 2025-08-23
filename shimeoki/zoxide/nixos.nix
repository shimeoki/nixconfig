{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.zoxide;

    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.zoxide = {
        enable = lib.mkEnableOption "zoxide" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
