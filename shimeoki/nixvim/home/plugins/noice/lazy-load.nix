{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim.plugins) lz-n;
in
{
    config = lib.mkIf lz-n.enable {
        programs.nixvim.plugins.noice.lazyLoad.settings = {
            event = [
                "DeferredUIEnter"
            ];
        };
    };
}
