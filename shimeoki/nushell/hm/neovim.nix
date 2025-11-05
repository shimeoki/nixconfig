{ config, lib, ... }:
let
    inherit (config.shimeoki) nushell nixvim;
in
{
    config = lib.mkIf (nushell.enable && nixvim.enable) {
        programs.nushell = {
            settings.keybindings = with nushell; [
                (bind {
                    name = "nvim";
                    keycode = "char_v";
                    event = {
                        send = "ExecuteHostCommand";
                        cmd = "nvim";
                    };
                })
            ];
        };
    };
}
