let
    bind = keys: action: "--bind='${keys}:${action}'";
in
{
    config = {
        programs.fzf.defaultOptions = [
            (bind "enter" "accept")
            (bind "U" "unix-line-discard")

            (bind "J" "preview-half-page-down")
            (bind "K" "preview-half-page-up")
            (bind "T" "toggle-preview")

            (bind "ctrl-h" "deselect+up")
            (bind "ctrl-j" "down")
            (bind "ctrl-k" "up")
            (bind "ctrl-l" "select+down")

            (bind "ctrl-u" "half-page-down")
            (bind "ctrl-i" "half-page-up")
        ];
    };
}
