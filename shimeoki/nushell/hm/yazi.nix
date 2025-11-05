{ config, lib, ... }:
let
    inherit (config.shimeoki) nushell dotfiles yazi;
in
{
    config = lib.mkIf (nushell.enable && dotfiles.enable && yazi.enable) {
        programs.nushell = {
            extraConfig = ''
                use ${dotfiles.config "nushell/modules/yazi.nu"}
                alias y = yazi cwd-on-exit
            '';

            settings.keybindings = with nushell; [
                (bind {
                    name = "yazi";
                    keycode = "char_e";
                    event = {
                        send = "ExecuteHostCommand";
                        cmd = "yazi cwd-on-exit";
                    };
                })
            ];
        };
    };
}
