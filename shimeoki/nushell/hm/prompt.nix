{ config, lib, ... }:
let
    inherit (config.shimeoki) git dotfiles;
in
{
    # git is used in the prompt
    config = lib.mkIf git.enable {
        programs.nushell.extraConfig = ''
            use ${dotfiles.config "nushell/prompt.nu"} []
        '';
    };
}
