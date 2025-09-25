{
    lib,
    ...
}:
{
    imports = [
        ./docker/nixos
        ./dotfiles/nixos
        ./greetd/nixos
        ./home-manager/nixos
        ./host/nixos
        ./kanata/nixos
        ./niri/nixos
        ./nushell/nixos
        ./obsidian/nixos
        ./stylix/nixos
        ./tlp/nixos
        ./uwsm/nixos
    ];

    options.shimeoki = {
        enable = lib.mkEnableOption "module";
    };
}
