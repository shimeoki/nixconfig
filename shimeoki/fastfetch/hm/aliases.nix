{ config, lib, ... }:
let
    inherit (config.shimeoki) fastfetch;
in
{
    config = lib.mkIf fastfetch.enable {
        home.shellAliases = {
            ff = "fastfetch";
        };
    };
}
