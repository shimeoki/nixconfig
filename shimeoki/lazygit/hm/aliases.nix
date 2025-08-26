{ config, lib, ... }:
let
    cfg = config.shimeoki.lazygit;
in
{
    config = lib.mkIf cfg.enable {
        home.shellAliases = {
            lg = "lazygit";
        };
    };
}
