{
    config,
    options,
    lib,
    ...
}:
let
    cfg = config.shimeoki.kitty;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.kitty = {
        enable = lib.mkEnableOption "kitty" // {
            default = true;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
