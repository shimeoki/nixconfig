{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) gpg;
in
{
    options.shimeoki.gpg = {
        enable = lib.mkEnableOption "gpg" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf gpg.enable {
        programs.gpg.enable = true;
        services.gpg-agent = {
            enable = true;
            pinentry.package = pkgs.pinentry-curses;
        };
    };
}
