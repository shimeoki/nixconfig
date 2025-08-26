{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.btop;
in
{
    imports = [
        ./aliases.nix
    ];

    options.shimeoki.btop = {
        enable = lib.mkEnableOption "btop" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.btop = {
            enable = true;
        };
    };
}
