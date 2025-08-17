{
    config,
    options,
    lib,
    ...
}:
let
    cfg = config.shimeoki.nh;
    home = options.home.homeDirectory;
in
{
    options.shimeoki.nh = {
        enable = lib.mkEnableOption "nh";
    };

    config = lib.mkIf cfg.enable {
        programs.nh = {
            enable = true;
            # note: flake for each user? maybe not really needed
            flake = "${home}/nixconfig";
        };
    };
}
