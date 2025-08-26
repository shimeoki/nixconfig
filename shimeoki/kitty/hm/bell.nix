{ config, lib, ... }:
let
    inherit (config.shimeoki) kitty;
in
{
    config = lib.mkIf kitty.enable {
        programs.kitty.settings = {
            enable_audio_bell = false;
        };
    };
}
