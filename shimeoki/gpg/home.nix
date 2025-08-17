{
    config,
    pkgs,
    lib,
    ...
}:
let
    cfg = config.shimeoki.gpg;
in
{
    options.shimeoki.gpg = {
        enable = lib.mkEnableOption "gpg";
    };

    config = lib.mkIf cfg.enable {
        programs.gpg.enable = true;
        services.gpg-agent = {
            enable = true;
            pinentry.package = pkgs.pinentry-curses;
        };
        # todo: git integration
    };
}
