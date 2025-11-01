{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) git delta;
in
{
    options.shimeoki.delta = {
        enable = lib.mkEnableOption "delta" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf delta.enable {
        programs.delta = {
            enable = true;
            enableGitIntegration = git.enable;
            options = {
                navigate = true;
                side-by-side = true;
                line-numbers = true;

                # NOTE: needed for stylix to work correctly
                syntax-theme = "base16-256";
                light = false;
            };
        };
    };
}
