{ config, lib, ... }:
let
    cfg = config.shimeoki.btop;
in
{
    config = lib.mkIf cfg.enable {
        home.shellAliases = {
            t = "btop";
        };
    };
}
