{ config, lib, ... }:
let
    module = config.shimeoki;
    cfg = module.yazi;
in
{
    imports = [
        ./preview.nix
        ./settings.nix
        ./binds.nix
        ./shell.nix
        ./plugins
    ];

    options.shimeoki.yazi = {
        enable = lib.mkEnableOption "yazi" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.yazi.enable = true;
    };
}
