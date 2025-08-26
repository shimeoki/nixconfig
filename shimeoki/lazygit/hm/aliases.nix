{ config, lib, ... }:
let
    inherit (config.shimeoki) lazygit;
in
{
    config = lib.mkIf lazygit.enable {
        home.shellAliases = {
            lg = "lazygit";
        };
    };
}
