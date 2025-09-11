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
                ];
            };
        };
    };
}
