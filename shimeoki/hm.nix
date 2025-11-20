{
    lib,
    ...
}:
{
    imports = [
        # keep-sorted start
        ./bat/hm
        ./btop/hm
        ./carapace/hm
        ./delta/hm
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
        ./materialgram/hm
        ./mpd/hm
        ./nh/hm
        ./niri/hm
        ./nix-search-tv/hm
        ./nixvim/hm
        ./nushell/hm
        ./obsidian/hm
        ./password-store/hm
        ./pwvucontrol/hm
        ./rmpc/hm
        ./ssh/hm
        ./stylix/hm
        ./swww/hm
        ./syncthing/hm
        ./uwsm/hm
        ./waybar/hm
        ./yazi/hm
        ./zen-browser/hm
        ./zoxide/hm
        # keep-sorted end
    ];

    options.shimeoki = {
        enable = lib.mkEnableOption "module";
    };
}
