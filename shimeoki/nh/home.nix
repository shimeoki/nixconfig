{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.nh;
in
{
    options.shimeoki.nh = {
        enable = lib.mkEnableOption "nh" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nh = {
            enable = true;
            # fix: hardcoded path
            flake = "/home/d/nixconfig";
        };
    };
}
