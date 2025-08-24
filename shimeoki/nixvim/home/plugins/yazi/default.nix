{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.yazi;
in
{
    imports = [
        ./binds.nix
        ./lazy-load.nix
    ];

    options.shimeoki.nixvim.plugins.yazi = {
        enable = lib.mkEnableOption "yazi" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim = {
            # todo: shimeoki module, fzf and fd dependencies?
            dependencies.yazi.enable = lib.mkForce true;
            plugins.yazi = {
                enable = true;
                settings = {
                    floating_window_scaling_factor = 1.0;
                    open_for_directories = true;
                    keymaps.show_help = "<f1>";
                };
            };
        };
    };
}
