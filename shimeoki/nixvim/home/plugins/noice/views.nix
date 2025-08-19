let
    highlights = "NormalFloat:NormalFloat,FloatBorder:FloatBorder";
    border = {
        style = "none";
        padding = [
            1
            1
        ];
    };
in
{
    config = {
        programs.nixvim.plugins.noice.settings = {
            # note: to not force a border
            cmdline.format.input.view = "cmdline_popup";
            views = {
                notify.replace = true;
                popup = {
                    inherit border;
                    filter_options = [ ];
                };
                cmdline_popup = {
                    inherit border;
                    filter_options = [ ];
                    win_options.winhighlight = highlights;
                };
                hover = {
                    inherit border;
                    filter_options = [ ];
                    position = {
                        row = 2;
                        col = 0;
                    };
                };
                confirm = {
                    inherit border;
                    filter_options = [ ];
                };
            };
        };
    };
}
