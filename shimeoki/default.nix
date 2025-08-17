{ lib, ... }:
{
    # todo: check for available flake inputs before importing

    imports = [
        ./gpg
        ./ssh
        ./kitty
        ./nh
        ./dotfiles
        ./git
        ./yazi
    ];

    options.shimeoki = {
        enable = lib.mkEnableOption "module";
    };
}
