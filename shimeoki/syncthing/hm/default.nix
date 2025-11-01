{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) syncthing;

    devices = {
        kaede = {
            id = "OUEHO5F-JBQ3HYU-DPHH4WH-NH6GZ7E-RDMV3O4-4CEKL66-3KDJK3N-V5UYKQB";
        };

        yuki = {
            id = "GLBAQZC-S5SQAN2-EWKQTZ7-2XNYFXA-PGLGYLQ-PAUMQKS-CGYNWXA-6SGJPAZ";
        };

        akane = {
            id = "YGDXQ2U-5ENEMMQ-7CLTQ4A-52WEK5L-DKJIPDU-DZKXPQP-OLHIOTS-KC3TJQ4";
        };
    };

    folders = {
        obsidian = {
            inherit (syncthing.obsidian) enable devices;
            id = "3lrbn-rrmv4";
            label = "Obsidian";
            path = "~/obsidian";
        };

        code = {
            inherit (syncthing.code) enable devices;
            id = "coevz-eczec";
            label = "Code";
            path = "~/code";
        };

        pictures = {
            inherit (syncthing.pictures) enable devices;
            id = "dxisy-umvl5";
            label = "Pictures";
            path = "~/Pictures";
        };

        documents = {
            inherit (syncthing.documents) enable devices;
            id = "5mzls-iaxas";
            label = "Documents";
            path = "~/Documents";
        };

        music = {
            inherit (syncthing.music) enable devices;
            id = "mejme-bzk7q";
            label = "Music";
            path = "~/Music";
        };

        password-store = {
            inherit (syncthing.password-store) enable devices;
            id = "c3nmn-4xeeo";
            label = "Password Store";
            path = "~/.local/share/password-store";
        };
    };

    folderDevices =
        devices:
        lib.mkOption {
            default = [ ];
            type = with lib.types; listOf (enum devices);
        };
in
{
    options.shimeoki.syncthing = {
        enable = lib.mkEnableOption "syncthing";

        obsidian = {
            enable = lib.mkEnableOption "obsidian";
            devices = folderDevices [
                "kaede"
                "akane"
                "yuki"
            ];
        };

        code = {
            enable = lib.mkEnableOption "code";
            devices = folderDevices [
                "kaede"
                "akane"
                "yuki"
            ];
        };

        pictures = {
            enable = lib.mkEnableOption "pictures";
            devices = folderDevices [
                "kaede"
                "yuki"
            ];
        };

        documents = {
            enable = lib.mkEnableOption "documents";
            devices = folderDevices [
                "kaede"
                "akane"
                "yuki"
            ];
        };

        music = {
            enable = lib.mkEnableOption "music";
            devices = folderDevices [
                "kaede"
                "akane"
            ];
        };

        password-store = {
            enable = lib.mkEnableOption "password-store";
            devices = folderDevices [
                "kaede"
                "akane"
                "yuki"
            ];
        };
    };

    config = lib.mkIf syncthing.enable {
        services.syncthing = {
            enable = true;
            settings = { inherit devices folders; };
        };
    };
}
