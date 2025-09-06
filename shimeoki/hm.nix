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
        ./home-manager/hm
        ./kitty/hm
        ./lazygit/hm
        ./nh/hm
        ./niri/hm
        ./nix-search-tv/hm
        ./nixvim/hm
        ./nushell/hm
        ./obsidian/hm
        ./password-store/hm
        ./ssh/hm
        ./stylix/hm
        ./swww/hm
        ./syncthing/hm
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
