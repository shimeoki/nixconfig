{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.ssh;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home.nix ];
    };
in
{
    options.shimeoki.ssh = {
        enable = lib.mkEnableOption "ssh" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
