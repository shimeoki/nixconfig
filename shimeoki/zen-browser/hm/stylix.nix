{ config, lib, ... }:
let
    inherit (config.shimeoki) zen-browser stylix;
in
{
    config = lib.mkIf (zen-browser.enable && stylix.enable) {
        stylix.targets.zen-browser = {
            profileNames = [ "main" ];
        };
    };
}
