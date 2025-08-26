{
    config,
    lib,
    ...
}:
let
    inherit (config.shimeoki) git;
    inherit (git) delta;
in
{
    options.shimeoki.git.delta = {
        enable = lib.mkEnableOption "delta" // {
            default = git.enable;
        };
    };

    config = lib.mkIf delta.enable {
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
