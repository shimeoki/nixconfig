{ config, lib, ... }:
let
    inherit (config) shimeoki;
    inherit (shimeoki) docker;
in
{
    options.shimeoki.docker = {
        enable = lib.mkEnableOption "docker" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf docker.enable {
        # FIXME: needs to be enabled imperatively
        virtualisation.docker = {
            enable = false; # because rootless
            rootless = {
                enable = true;
                setSocketVariable = true;
            };
        };
    };
}
