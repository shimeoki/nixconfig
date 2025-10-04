{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim.plugins) blink;
in
{
    config = lib.mkIf blink.enable {
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
                        columns = [
                            { __unkeyed-1 = "item_idx"; }
                            { __unkeyed-1 = "label"; }
                            { __unkeyed-1 = "label_description"; }
                            { __unkeyed-1 = "kind_icon"; }
                            { __unkeyed-1 = "kind"; }
                            { __unkeyed-1 = "source_name"; }
                        ];
                        components.item_idx.text.__raw = ''
                            function(ctx)
                                if ctx.idx <= 9 then
                                    return tostring(ctx.idx)
                                else
                                    return " "
                                end
                            end
                        '';
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
                "exact"
                {
                    __raw = ''
                        function(a, b)
                            local source_priority = {
                                snippets = 4,
                                lsp = 3,
                                path = 2,
                                buffer = 1,
                            }

                            local a_priority = source_priority[a.source_id]
                            local b_priority = source_priority[b.source_id]

                            if a_priority ~= b_priority then
                                return a_priority > b_priority
                            end
                        end
                    '';
                }
                "score"
                "sort_text"
            ];
        };
    };
}
