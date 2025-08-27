{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) syncthing;
    inherit (syncthing) presets;

    presetDevices = {
        kaede = {
            id = "OUEHO5F-JBQ3HYU-DPHH4WH-NH6GZ7E-RDMV3O4-4CEKL66-3KDJK3N-V5UYKQB";
        };
    };

    presetFolders = {
        obsidian = {
            inherit (presets.obsidian) enable;
            id = "3lrbn-rrmv4";
            label = "Obsidian";
            path = "~/obsidian";
            devices = [ "kaede" ];
        };

        code = {
            inherit (presets.code) enable;
            id = "coevz-eczec";
            label = "Code";
            path = "~/code";
            devices = [ "kaede" ];
        };

        pictures = {
            inherit (presets.pictures) enable;
            id = "dxisy-umvl5";
            label = "Pictures";
            path = "~/Pictures";
            devices = [ "kaede" ];
        };

        documents = {
            inherit (presets.documents) enable;
            id = "5mzls-iaxas";
            label = "Documents";
            path = "~/Documents";
            devices = [ "kaede" ];
        };

        music = {
            inherit (presets.music) enable;
            id = "mejme-bzk7q";
            label = "Music";
            path = "~/Music";
            devices = [ "kaede" ];
        };

        password-store = {
            inherit (presets.password-store) enable;
            id = "c3nmn-4xeeo";
            label = "Password Store";
            path = "~/.local/share/password-store";
            devices = [ "kaede" ];
        };
    };

    devices =
        with lib;
        mkMerge ([ syncthing.devices ] ++ optional presets.enable presetDevices);

    folders =
        with lib;
        mkMerge ([ syncthing.folders ] ++ optional presets.enable presetFolders);
in
{
    options.shimeoki.syncthing = with lib; {
        enable = mkEnableOption "syncthing" // {
            default = shimeoki.enable;
        };

        presets = {
            enable = mkEnableOption "presets";

            obsidian = {
                enable = mkEnableOption "obsidian";
            };

            code = {
                enable = mkEnableOption "code";
            };

            pictures = {
                enable = mkEnableOption "pictures";
            };

            documents = {
                enable = mkEnableOption "documents";
            };

            music = {
                enable = mkEnableOption "music";
            };

            password-store = {
                enable = mkEnableOption "password-store";
            };
        };

        devices = mkOption {
            default = { };
            type = types.attrsOf (
                types.submodule {
                    id = mkOption {
                        type = types.str;
                    };

                    label = mkOption {
                        type = types.str;
                    };

                    path = mkOption {
                        type = types.str; # fix: should start with / or ~/
                    };

                    devices = mkOption {
                        type = with types; listOf str;
                    };
                }
            );
        };

        folders = mkOption {
            default = { };
            type = types.attrsOf (
                types.submodule {
                    id = mkOption {
                        type = types.str;
                    };
                }
            );
        };
    };

    config = lib.mkIf syncthing.enable {
        services.syncthing = {
            enable = true;
            settings = { inherit devices folders; };
        };
    };
}
