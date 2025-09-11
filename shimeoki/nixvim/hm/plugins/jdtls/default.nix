{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;

    settings = {
        signatureHelp.enabled = true;
        format.enabled = true;
        implementationsCodeLens.enabled = true;
        inlayHints = {
            enabled = true;
            parameterNames.enabled = "All";
        };
    };

    root = ''
        vim.fs.root(0, {
            ".git",
            "gradlew",
            "gradlew.bat",
            "settings.gradle",
            "settings.gradle.kts",
            "pom.xml",
        })
    '';

    dir = ''vim.fn.fnamemodify(${root}, ":p:h")'';
in
{
    options.shimeoki.plugins.jdtls = {
        enable = lib.mkEnableOption "jdtls" // {
            default = true;
        };
    };

    config = lib.mkIf plugins.enable {
        programs.nixvim.plugins.jdtls = {
            enable = true;
            settings = {
                inherit settings;
                root_dir.__raw = root;
                cmd = [
                    "jdtls"
                    "-data"
                    {
                        __raw = ''
                            vim.fn.stdpath("cache") .. "/jdtls/" .. ${dir}
                        '';
                    }
                ];
            };
        };
    };
}
