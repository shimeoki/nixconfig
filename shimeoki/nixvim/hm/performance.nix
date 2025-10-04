{
    config = {
        programs.nixvim.performance = {
            byteCompileLua = {
                enable = true;
                configs = true;
                initLua = true;
                luaLib = true;
                nvimRuntime = true;
                plugins = true;
            };

            combinePlugins = {
                enable = true;
                standalonePlugins = [
                    "conform.nvim"
                    "nvim-jdtls"
                    "friendly-snippets" # HACK: https://github.com/nix-community/nixvim/issues/2746
                ];
            };
        };
    };
}
