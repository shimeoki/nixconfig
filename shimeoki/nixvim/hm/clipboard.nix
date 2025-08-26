{
    config = {
        programs.nixvim.clipboard = {
            register = "unnamedplus"; # share with system
            providers.wl-copy.enable = true; # note: what about non-wayland?
        };
    };
}
