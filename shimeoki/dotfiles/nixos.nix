{
    options,
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) dotfiles;

    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home.nix ];
    };

    nixos = lib.mkIf dotfiles.enable {
        environment.systemPackages = [ dotfiles.scripts ];
    };
in
{
    imports = [ ./shared.nix ];

    options.shimeoki.dotfiles = {
        enable = lib.mkEnableOption "dotfiles" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkMerge [
        home
        nixos
    ];
}
