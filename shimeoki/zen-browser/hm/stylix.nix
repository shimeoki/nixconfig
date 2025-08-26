{ config, lib, ... }:
let
    inherit (config.shimeoki) stylix;
in
{
    config = lib.mkIf stylix.enable {
        stylix.targets.zen-browser = {
            profileNames = [ "main" ];
        };
    };
}
