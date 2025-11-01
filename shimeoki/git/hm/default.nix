{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) git;
in
{
    imports = [
        ./user.nix
        ./settings.nix
        ./aliases.nix
    ];

    options.shimeoki.git = {
        enable = lib.mkEnableOption "git" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf git.enable {
        programs.git.enable = true;
    };
}
