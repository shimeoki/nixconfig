{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.git;
in
{

    imports = [
        ./user.nix
        ./settings.nix
        ./aliases.nix
        ./delta
    ];

    options.shimeoki.git = {
        enable = lib.mkEnableOption "git" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.git.enable = true;
    };
}
