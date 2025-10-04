{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim.plugins) blink;

    showBind = providers: {
        __unkeyed-1.__raw = ''
            function(cmp)
                cmp.show({ providers = { ${providers} } })
            end
        '';
        __unkeyed-2 = "fallback_to_mappings";
    };

    indexBind = index: {
        __unkeyed-1.__raw = ''
            function(cmp)
                cmp.accept({ index = ${builtins.toString index} })
            end
        '';
    };

    indexBinds = lib.listToAttrs (
        lib.map (i: {
            name = "<c-${builtins.toString i}>";
            value = indexBind i;
        }) (lib.range 1 9)
    );
in
{
    config = lib.mkIf blink.enable {
        programs.nixvim.plugins.blink-cmp.settings = {
            cmdline.keymap.preset = "inherit";
            keymap = {
                preset = "none";

                "<enter>" = [
                    "accept"
                    "snippet_forward"
                    "fallback"
                ];

                "<tab>" = [
                    "accept"
                    "snippet_forward"
                    "fallback"
                ];

                "<c-s>" = [
                    "show"
                    "hide"
                    "fallback_to_mappings"
                ];

                "<c-a>" = showBind ''"lsp", "snippets", "path"'';
                "<c-e>" = showBind ''"lsp", "path"'';
                "<c-o>" = showBind ''"snippets"'';

                "<c-j>" = [
                    "select_next"
                    "fallback_to_mappings"
                ];

                "<c-k>" = [
                    "select_prev"
                    "fallback_to_mappings"
                ];

                "<c-h>" = [
                    "snippet_backward"
                    "fallback_to_mappings"
                ];

                "<c-l>" = [
                    "snippet_forward"
                    "fallback_to_mappings"
                ];

                "<c-d>" = [
                    "scroll_documentation_down"
                    "fallback"
                ];

                "<c-u>" = [
                    "scroll_documentation_up"
                    "fallback"
                ];

                "<c-t>" = [
                    "show_signature"
                    "hide_signature"
                    "fallback"
                ];

                "<c-i>" = [
                    "show_documentation"
                    "hide_documentation"
                    "fallback"
                ];
            }
            // indexBinds;
        };
    };
}
