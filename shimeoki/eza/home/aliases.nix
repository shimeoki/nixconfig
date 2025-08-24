{ config, lib, ... }:
let
    cfg = config.shimeoki.eza;
in
{
    config = lib.mkIf cfg.enable {
        home.shellAliases = {
            l = "eza --oneline";
            la = "eza --oneline --all";

            ll = "eza --long";
            lla = "eza --long --all";

            lt = "eza --tree";
            lta = "eza --tree --all";
        };
    };
}
