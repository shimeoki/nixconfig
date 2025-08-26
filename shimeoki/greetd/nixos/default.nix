{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) greetd;
in
{
    imports = [
        ./niri.nix
    ];

    options.shimeoki.greetd = {
        enable = lib.mkEnableOption "greetd" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf greetd.enable {
        services.greetd = {
            enable = true;
            useTextGreeter = true;
            settings.default_session = {
                command = "${pkgs.tuigreet}/bin/tuigreet --user-menu --time --asterisks --remember --remember-user-session";
            };
        };
    };
}
