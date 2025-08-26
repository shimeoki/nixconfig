{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.zoxide;
in
{
    options.shimeoki.zoxide = {
        enable = lib.mkEnableOption "zoxide" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.zoxide = {
            enable = true;
            options = [ "--cmd=j" ];
        };
    };
}
