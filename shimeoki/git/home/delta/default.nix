{
    config,
    lib,
    ...
}:
let
    inherit (config.shimeoki) git;
    cfg = git.delta;
in
{
    options.shimeoki.git.delta = {
        enable = lib.mkEnableOption "delta" // {
            default = git.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.git.delta = {
            enable = true;
            options = {
                navigate = true;
                side-by-side = true;
                line-numbers = true;
            };
        };
    };
}
