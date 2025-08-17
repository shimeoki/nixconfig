{ config, lib, ... }:
let
    cfg = config.shimeoki.yazi;
in
{
    imports = [
        ./preview.nix
        ./settings.nix
        ./binds.nix
        ./plugins
    ];

    options.shimeoki.yazi = {
        enable = lib.mkEnableOption "yazi";
    };

    config = lib.mkIf cfg.enable {
        programs.yazi.enable = true;
    };
}
