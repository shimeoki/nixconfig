{
    config,
    lib,
    ...
}:
let
    cfg = config.shimeoki.git;
in
{

    imports = [
        ./user.nix
        ./settings.nix
        ./aliases.nix
    ];

    options.shimeoki.git = {
        enable = lib.mkEnableOption "git";
    };

    config = lib.mkIf cfg.enable {
        programs.git.enable = true;
    };
}
