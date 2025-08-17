{
    config,
    lib,
    ...
}:
let
    cfg = config.shimeoki.nh;
in
{
    options.shimeoki.nh = {
        enable = lib.mkEnableOption "nh";
    };

    config = lib.mkIf cfg.enable {
        programs.nh = {
            enable = true;
            # fix: hardcoded path
            flake = "/home/d/nixconfig";
        };
    };
}
