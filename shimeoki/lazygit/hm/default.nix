{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.lazygit;
in
{

    imports = [
        ./settings.nix
        ./aliases.nix
    ];

    options.shimeoki.lazygit = {
        enable = lib.mkEnableOption "lazygit" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.lazygit.enable = true;
    };
}
