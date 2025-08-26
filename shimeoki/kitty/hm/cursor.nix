{ config, lib, ... }:
let
    inherit (config.shimeoki) kitty;
in
{
    config = lib.mkIf kitty.enable {
        programs.kitty.settings = {
            cursor_trail = 3;
            cursor_trail_decay = "0.1 0.4";
        };
    };
}
