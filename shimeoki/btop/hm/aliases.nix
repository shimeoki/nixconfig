{ config, lib, ... }:
let
    inherit (config.shimeoki) btop;
in
{
    config = lib.mkIf btop.enable {
        home.shellAliases = {
            t = "btop";
        };
    };
}
