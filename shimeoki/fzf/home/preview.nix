{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config.shimeoki)
        fzf
        bat
        eza
        kitty
        ;

    # bat, eza and kitty are needed for
    # file, directory and image previews respectively
    enable = fzf.enable && bat.enable && eza.enable && kitty.enable;

    opts = [
        "--height=100%"
        "--preview='fzf-preview.bash {}'"
    ];

    fileWidgetOptions = opts;
    changeDirWidgetOptions = opts;
in
{
    # fix: check for dotfiles scripts
    config = lib.mkIf enable {
        home.packages = [ pkgs.file ]; # dependency for the fzf-preview.bash
        programs.fzf = {
            inherit
                fileWidgetOptions
                changeDirWidgetOptions
                ;
        };
    };
}
