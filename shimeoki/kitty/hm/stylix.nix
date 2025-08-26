{ config, lib, ... }:
let
    inherit (config.shimeoki) kitty stylix;
in
{
    config = lib.mkIf (kitty.enable && stylix.enable) {
        stylix.targets.kitty = {
            variant256Colors = true;
        };
    };
}
