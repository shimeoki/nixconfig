{ pkgs, ... }:
{
    home.packages = with pkgs; [
        # keep-sorted start
        baobab
        croc
        dust
        gitleaks
        trash-cli
        # keep-sorted end
    ];
}
