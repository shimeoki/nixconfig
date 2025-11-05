{ config, lib, ... }:
let
    inherit (config.shimeoki) nushell lazygit;
in
{
    config = lib.mkIf (nushell.enable && lazygit.enable) {
        programs.nushell = {
            settings.keybindings = with nushell; [
                (bind {
                    name = "lazygit";
                    keycode = "char_g";
                    event = {
                        send = "ExecuteHostCommand";
                        cmd = "lazygit";
                    };
                })
            ];
        };
    };
}
