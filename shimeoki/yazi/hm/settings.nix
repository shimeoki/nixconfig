{ config, lib, ... }:
let
    cfg = config.shimeoki.yazi;
    inherit (config.shimeoki) dotfiles;
in
{
    config = lib.mkIf cfg.enable {
        shimeoki.yazi.plugins = {
            # note: for the initLua below
            git.enable = lib.mkForce true;
            full-border.enable = lib.mkForce true;
        };
        programs.yazi = {
            # fix: just the path doesn't work
            initLua = builtins.readFile (dotfiles.config "yazi/init.lua");
            settings.mgr = {
                ratio = [
                    1
                    3
                    3
                ];
                sort_by = "natural";
                sort_dir_first = true;
                sort_translit = true;
                linemode = "none";
                show_symlink = true;
                scrolloff = 5;
            };
        };
    };
}
