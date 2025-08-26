{
    config,
    lib,
    ...
}:
let
    inherit (config.shimeoki) fzf fd;

    defaultCommand = "fd --hidden --follow";
    fileWidgetCommand = "${defaultCommand} --type=file";
    changeDirWidgetCommand = "${defaultCommand} --type=dir";
in
{
    config = lib.mkIf (fzf.enable && fd.enable) {
        programs.fzf = {
            inherit
                defaultCommand
                fileWidgetCommand
                changeDirWidgetCommand
                ;
        };
    };
}
