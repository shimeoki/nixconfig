{ config, lib, ... }:
let
    inherit (config.shimeoki) stylix;
in
{
    config = lib.mkIf stylix.enable {
        stylix.targets.kitty = {
            variant256Colors = true;
        };
    };
}
