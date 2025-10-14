{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim.plugins) lz-n;
in
{
    config = lib.mkIf lz-n.enable {
        programs.nixvim.plugins.conform-nvim.lazyLoad.settings = {
            event = [
                "BufWritePre"
                "DeferredUIEnter" # see note below
            ];

            # NOTE: if you uncomment cmd's, custom commands will be overriden,
            # because the lazy-loader creates a custom command with the same
            # name to load the plugin. to fix this, you would create custom
            # commands in the hook after loading the plugin. so it goes like
            # this: exec fake cmd -> load -> create real cmd -> exec real cmd.
            # but with nixvim i don't think there is a simple way to do this,
            # so i use deferred loading that custom commands just would work
            # afterwards

            # cmd = [
            #     "Format"
            #     "FormatEnable"
            #     "FormatDisable"
            # ];
        };
    };
}
