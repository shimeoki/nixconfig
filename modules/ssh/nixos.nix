{
    config,
    options,
    lib,
    ...
}:
let
    cfg = config.shimeoki.ssh;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home.nix ];
    };
in
{
    options.shimeoki.ssh = {
        enable = lib.mkEnableOption "ssh" // {
            default = true;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
