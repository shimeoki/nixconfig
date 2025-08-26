{ config, lib, ... }:
let
    inherit (config.shimeoki) eza;
in
{
    config = lib.mkIf eza.enable {
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
