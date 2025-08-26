{ config, lib, ... }:
let
    inherit (config.shimeoki) bat;
in
{
    config = lib.mkIf bat.enable {
        home.shellAliases = {
            b = "bat";
            bp = "bat --plain";
            h = "batman";
        };
    };
}
