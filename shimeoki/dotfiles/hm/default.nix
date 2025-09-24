{
    inputs,
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) dotfiles;
in
{
    imports = [ inputs.dotfiles.homeModules.default ];

    options.shimeoki.dotfiles = {
        enable = lib.mkEnableOption "dotfiles" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf dotfiles.enable {
        home.packages = [ inputs.dotfiles.packages.${pkgs.system}.default ];
    };
}
