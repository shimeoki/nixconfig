{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.eza;
    inherit (module) git;
in
{
    imports = [
        ./aliases.nix
    ];

    options.shimeoki.eza = {
        enable = lib.mkEnableOption "eza" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.eza = {
            enable = true;
            git = git.enable;
            colors = "always";
            icons = "auto";
            extraOptions = [
                "--group-directories-first"
                "--no-quotes"
                "--ignore-glob=.git"
            ];
        };
    };
}
