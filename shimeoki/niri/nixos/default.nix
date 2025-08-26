{
    config,
    lib,
    inputs,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.niri;
in
{
    imports = [
        inputs.niri.nixosModules.niri
    ];

    options.shimeoki.niri = {
        enable = lib.mkEnableOption "niri" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.niri.enable = true;
    };
}
