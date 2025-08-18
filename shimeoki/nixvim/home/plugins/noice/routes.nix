{
    config = {
        programs.nixvim.plugins.noice.settings.routes = [
            {
                # note: hide search virtual text
                opts.skip = true;
                filter = {
                    event = "msg_show";
                    kind = "search_count";
                };
            }
            {
                # note: hide written messages
                opts.skip = true;
                filter = {
                    event = "msg_show";
                    kind = "";
                    find = "written";
                };
            }
        ];
    };
}
