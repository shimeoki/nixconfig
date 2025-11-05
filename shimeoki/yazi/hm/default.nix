{ config, lib, ... }:
let
    module = config.shimeoki;
    cfg = module.yazi;
in
{
    imports = [
        ./plugins

        # keep-sorted start
        ./binds.nix
        ./preview.nix
        ./settings.nix
        ./shell.nix
        # keep-sorted end
    ];

    options.shimeoki.yazi = {
        enable = lib.mkEnableOption "yazi" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.yazi = {
            enable = true;
            enableNushellIntegration = false; # NOTE: managed by nushell module
        };
    };
}
