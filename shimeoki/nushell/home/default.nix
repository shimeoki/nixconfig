{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.nushell;
in
{
    imports = [
        ./settings.nix
        ./prompt.nix
    ];

    options.shimeoki.nushell = {
        enable = lib.mkEnableOption "nushell" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nushell.enable = true;
    };
}
