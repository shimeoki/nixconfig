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
            {
                # note: hide jdtls progress
                opts.skip = true;
                filter = {
                    event = "lsp";
                    kind = "progress";
                    cond.__raw = ''
                        function(m)
                            if not m.opts or not m.opts.progress then
                                return false
                            end

                            local msg = m.opts.progress

                            if msg.client ~= "jdtls" then
                                return false
                            end

                            local jdtls_progress = {
                                ["Building"] = true,
                                ["Validate documents"] = true,
                                ["Publish Diagnostics"] = true,
                            }

                            return jdtls_progress[msg.message] or false
                        end
                    '';
                };
            }
        ];
    };
}
