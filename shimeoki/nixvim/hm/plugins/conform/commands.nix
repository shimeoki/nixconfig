{
    config,
    lib,
    ...
}:
let
    inherit (config.shimeoki.nixvim.plugins) conform;
in
{
    config = lib.mkIf conform.enable {
        programs.nixvim.userCommands = {
            "Format" = {
                range = true;
                command.__raw = ''
                    function(args)
                        local range = nil
                        if args.count ~= -1 then
                            local count = vim.api.nvim_buf_get_lines(
                                0,
                                args.line2 - 1,
                                args.line2,
                                true
                            )[1]:len()

                            range = {
                                ["start"] = { args.line1, 0 },
                                ["end"] = { args.line2, count },
                            }
                        end

                        require("conform").format({
                            async = true,
                            lsp_format = "fallback",
                            range = range,
                        })
                    end
                '';
            };

            "FormatDisable" = {
                desc = "disable format on save";
                bang = true;
                command.__raw = ''
                    function(args)
                        if args.bang then
                            vim.b.disable_format = true
                        else
                            vim.g.disable_format = true
                        end
                    end
                '';
            };

            "FormatEnable" = {
                desc = "enable format on save";
                command.__raw = ''
                    function()
                        vim.b.disable_format = false
                        vim.g.disable_format = false
                    end
                '';
            };
        };
    };
}
