{
    lib,
    ...
}:
{
    imports = [
        ./dotfiles/nixos
        ./greetd/nixos
        ./home-manager/nixos
        ./host/nixos
        ./kanata/nixos
        ./niri/nixos
        ./nushell/nixos
        ./stylix/nixos
        ./tlp/nixos
        ./uwsm/nixos
        ./obsidian/nixos
    ];

    options.shimeoki = {
        enable = lib.mkEnableOption "module";
    };
}
