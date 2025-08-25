{ config, lib, ... }:
let
    inherit (config) shimeoki;
    inherit (shimeoki) dotfiles;
in
{
    imports = [ ./shared.nix ];

    options.shimeoki.dotfiles = {
        enable = lib.mkEnableOption "dotfiles" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf dotfiles.enable {
        home.packages = [ dotfiles.scripts ];
    };
}
