{
    config,
    options,
    lib,
    ...
}:
let
    cfg = config.shimeoki;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home.nix ];
    };
in
{
    options.shimeoki = {
        enable = lib.mkEnableOption "module";
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
