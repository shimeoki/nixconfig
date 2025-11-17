{ pkgs, ... }:
{
    home.packages = with pkgs; [
        # keep-sorted start
        baobab
        croc
        trash-cli
        # keep-sorted end
    ];
}
