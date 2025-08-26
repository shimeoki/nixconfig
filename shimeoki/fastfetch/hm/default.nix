{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) fastfetch;

    type = if fastfetch.logo then "small" else "none";
in
{
    imports = [
        ./aliases.nix
    ];

    options.shimeoki.fastfetch = {
        enable = lib.mkEnableOption "fastfetch" // {
            default = shimeoki.enable;
        };

        logo = lib.mkEnableOption "logo";
    };

    config = lib.mkIf fastfetch.enable {
        programs.fastfetch = {
            enable = true;
            settings = {
                logo = {
                    inherit type;
                    padding = {
                        top = 2;
                        left = 3;
                        right = 4;
                    };
                };

                display = {
                    separator = " ";
                    key.width = 8;
                };

                modules = [
                    "title"
                    {
                        type = "os";
                        key = "os";
                    }
                    {
                        type = "kernel";
                        key = "ker";
                    }
                    {
                        type = "host";
                        key = "host";
                    }
                    {
                        type = "uptime";
                        key = "up";
                    }
                    {
                        type = "memory";
                        key = "ram";
                    }
                    {
                        type = "packages";
                        key = "pkgs";
                    }
                    {
                        type = "shell";
                        key = "sh";
                    }
                    {
                        type = "wm";
                        key = "wm";
                    }
                    {
                        type = "terminal";
                        key = "term";
                    }
                    {
                        type = "terminalfont";
                        key = "font";
                    }
                ];
            };
        };
    };
}
