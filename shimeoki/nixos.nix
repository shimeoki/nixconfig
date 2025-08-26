{
    config,
    options,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
in
{
    imports = [
        ./dotfiles/nixos
        ./greetd/nixos
        ./host/nixos
        ./kanata/nixos
        ./niri/nixos
        ./nushell/nixos
        ./stylix/nixos
        ./tlp/nixos
        ./uwsm/nixos
    ];

    options.shimeoki = {
        enable = lib.mkEnableOption "module";
    };

    config = lib.mkIf (shimeoki.enable && options ? home-manager) {
        home-manager.sharedModules = [ ./hm.nix ];
    };
}
