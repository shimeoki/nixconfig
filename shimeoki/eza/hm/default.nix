{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) eza git;
in
{
    imports = [
        ./aliases.nix
    ];

    options.shimeoki.eza = {
        enable = lib.mkEnableOption "eza" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf eza.enable {
        programs.eza = {
            enable = true;
            git = git.enable;
            colors = "always";
            icons = "auto";
            enableBashIntegration = false;
            enableNushellIntegration = false;
            extraOptions = [
                "--group-directories-first"
                "--no-quotes"
                "--ignore-glob=.git"
            ];
        };
    };
}
