{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.languages.lua;
    inherit (config.shimeoki.nixvim.plugins) lsp;
in
{
    config = lib.mkIf (cfg.enable && lsp.enable) {
        programs.nixvim.lsp.servers = {
            lua_ls = {
                enable = true;
                settings.settings.Lua = {
                    # todo: on_init function
                    runtime = {
                        version = "LuaJIT";
                    };
                    diagnostics = {
                        globals = [
                            "vim"
                            "require"
                        ];
                    };
                    telemetry = {
                        enable = false;
                    };
                    format = {
                        enable = false;
                    };
                    hint = {
                        enable = true;
                        arrayIndex = "Auto";
                        await = true;
                        paramName = "Literal";
                        paramType = true;
                        semicolon = "SameLine";
                        setType = true;
                    };
                };
            };
        };
    };
}
