{ config, lib, ... }:
let
    inherit (config.shimeoki) nushell dotfiles zoxide;
in
{
    config = lib.mkIf (nushell.enable && dotfiles.enable && zoxide.enable) {
        programs.nushell = {
            extraConfig = ''
                use ${dotfiles.config "nushell/modules/zoxide.nu"}
                alias j  = zoxide jump
                alias ji = zoxide jumper
            '';

            settings.keybindings = with nushell; [
                (bindShift {
                    name = "zoxide";
                    keycode = "char_e";
                    event = {
                        send = "ExecuteHostCommand";
                        cmd = "zoxide jumper";
                    };
                })
            ];
        };
    };
}
