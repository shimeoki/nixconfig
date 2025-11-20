{ config, lib, ... }:
let
    inherit (config.shimeoki) lazygit delta;
in
{
    config = lib.mkIf (lazygit.enable && delta.enable) {
        programs.lazygit.settings = {
            git.pagers = [
                { pager = "delta --paging=never"; }
            ];
        };
    };
}
