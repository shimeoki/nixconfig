{ config, lib, ... }:
let
    inherit (config.shimeoki) lazygit delta;
in
{
    config = lib.mkIf (lazygit.enable && delta.enable) {
        programs.lazygit.settings = {
            git.paging.pager = "delta --paging=never";
        };
    };
}
