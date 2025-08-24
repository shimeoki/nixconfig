{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.fd;
in
{
    options.shimeoki.fd = {
        enable = lib.mkEnableOption "fd" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.fd = {
            enable = true;
            hidden = true;
            ignores = [ ".git" ];
        };
    };
}
