{
    config = {
        programs.nixvim.globals = {
            # disable netrw (directory listing)
            loaded_netrw = 1;
            loaded_netrwPlugin = 1;
        };
    };
}
