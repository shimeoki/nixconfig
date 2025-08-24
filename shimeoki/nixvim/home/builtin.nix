{
    config = {
        programs.nixvim.globals = {
            # disable netrw (directory listing)
            loaded_netrw = 1;
            loaded_netrwPlugin = 1;

            # disable zip (i haven't even used it)
            loaded_zip = 1;
            loaded_zipPlugin = 1;

            # disable gzip
            loaded_gzip = 1;

            # disable tar
            loaded_tar = 1;
            loaded_tarPlugin = 1;
        };
    };
}
