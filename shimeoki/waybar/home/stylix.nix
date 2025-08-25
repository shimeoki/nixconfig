{ config, lib, ... }:
let
    inherit (config.shimeoki) stylix;
in
{
    config = lib.mkIf stylix.enable {
        stylix.targets.waybar = {
            enableLeftBackColors = true;
            enableCenterBackColors = true;
            enableRightBackColors = true;
        };
    };
}
