{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim.plugins) lz-n;
in
{
    config = lib.mkIf lz-n.enable {
        programs.nixvim.plugins.yazi.lazyLoad.settings = {
            event = [ "DeferredUIEnter" ]; # to open directories on start
            cmd = [ "Yazi" ];
        };
    };
}
