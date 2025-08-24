{ config, lib, ... }:
let
    cfg = config.shimeoki.bat;
in
{
    config = lib.mkIf cfg.enable {
        home.shellAliases = {
            b = "bat";
            bp = "bat --plain";
            h = "batman";
        };
    };
}
