{ config, lib, ... }:
let
    cfg = config.shimeoki.eza;
in
{
    config = lib.mkIf cfg.enable {
        home.shellAliases = {
            ff = "fastfetch";
        };
    };
}
