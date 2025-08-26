{
    config = {
        programs.nixvim.plugins.blink-cmp.settings = {
            signature.enabled = false;
            completion = {
                keyword.range = "full";
                list.selection = {
                    preselect = true;
                    auto_insert = false;
                };
                ghost_text.enabled = true;
                documentation = {
                    auto_show = true;
                    auto_show_delay_ms = 0;
                };
                trigger = {
                    prefetch_on_insert = true;
                    show_in_snippet = true;
                    show_on_keyword = true;
                    show_on_trigger_character = true;
                };
                menu = {
                    max_height = 11;
                    direction_priority = [
                        "n"
                        "s"
                    ];
                    draw = {
                        # todo: item idx
                        columns = [
                            { __unkeyed-1 = "label"; }
                            { __unkeyed-1 = "label_description"; }
                            { __unkeyed-1 = "kind_icon"; }
                            { __unkeyed-1 = "kind"; }
                            { __unkeyed-1 = "source_name"; }
                        ];
                    };
                };
            };
            cmdline.completion = {
                list.selection = {
                    preselect = false;
                    auto_insert = false;
                };
                menu.auto_show = true;
            };
            fuzzy.sorts = [
                "score"
                "sort_text"
            ]; # todo: exact and source sort
        };
    };
}
