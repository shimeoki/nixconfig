{ config, lib, ... }:
let
    inherit (config.shimeoki) kitty;
in
{
    config = lib.mkIf kitty.enable {
        home.shellAliases = {
            icat = "kitten icat";
            s = "kitten ssh";
        };
    };
}
