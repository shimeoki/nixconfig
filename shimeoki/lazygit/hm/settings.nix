{ config, lib, ... }:
let
    inherit (config.shimeoki) lazygit;
in
{
    config = lib.mkIf lazygit.enable {
        programs.lazygit.settings = {
            gui = {
                scrollHeight = 4;
                scrollPastBottom = true;

                sidePanelWidth = 0.25;
                expandFocusedSidePanel = true;
                expandedSidePanelWeight = 2;
                mainPanelSplitMode = "flexible";
                enlargedSideViewLocation = "top";

                timeFormat = "2006-01-02 (Mon, Jan 01)";
                shortTimeFormat = "15:04";

                nerdFontsVersion = 3; # todo: check for nerd font
                showFileIcons = true;

                screenMode = "half";
                splitDiff = "auto";
                border = "single";
                portraitMode = "auto";

                filterMode = "fuzzy";
            };

            git.paging = {
                colorArg = "always";
            };
        };
    };
}
