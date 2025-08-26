{ config, lib, ... }:
let
    inherit (config.shimeoki) nushell git dotfiles;
in
{
    config = lib.mkIf (nushell.enable && git.enable) {
        programs.nushell.extraConfig = ''
            use ${dotfiles.config "nushell/prompt.nu"} []
        '';
    };
}
