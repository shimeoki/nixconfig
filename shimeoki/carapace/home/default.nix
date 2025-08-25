{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.carapace;
in
{
    options.shimeoki.carapace = {
        enable = lib.mkEnableOption "carapace" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.carapace.enable = true;
    };
}
