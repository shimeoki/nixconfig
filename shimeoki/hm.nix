{
    lib,
    ...
}:
{
    imports = [
        ./bat/hm
        ./btop/hm
        ./carapace/hm
        ./dotfiles/hm
        ./dunst/hm
        ./eza/hm
        ./fastfetch/hm
        ./fd/hm
        ./fuzzel/hm
        ./fzf/hm
        ./git/hm
        ./gpg/hm
        ./kitty/hm
        ./lazygit/hm
        ./nh/hm
        ./niri/hm
        ./nixvim/hm
        ./nushell/hm
        ./ssh/hm
        ./stylix/hm
        ./uwsm/hm
        ./waybar/hm
        ./yazi/hm
        ./zen-browser/hm
        ./zoxide/hm
    ];

    options.shimeoki = {
        enable = lib.mkEnableOption "module";
    };
}
