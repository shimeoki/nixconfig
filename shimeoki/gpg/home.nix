{
    config,
    pkgs,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.gpg;
in
{
    options.shimeoki.gpg = {
        enable = lib.mkEnableOption "gpg" // {
            default = module.enable;
        };
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
