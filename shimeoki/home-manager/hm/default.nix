{ config, lib, ... }:
let
    inherit (config) shimeoki;
    inherit (shimeoki) home-manager;
in
{
    options.shimeoki.home-manager = {
        enable = lib.mkEnableOption "home-manager" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf home-manager.enable {
        programs.home-manager.enable = true;
    };
}
