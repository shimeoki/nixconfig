{ config, lib, ... }:
let
    inherit (config.shimeoki) stylix;
in
{
    config = lib.mkIf stylix.enable {
        stylix.targets.nixvim = {
            plugin = "base16-nvim";
            transparentBackground = {
                main = true;
                numberLine = true;
                signColumn = true;
            };
        };
    };
}
