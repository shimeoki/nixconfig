{
    config = {
        programs.yazi.keymap.mgr.prepend_keymap = [
            {
                on = [ "!" ];
                run = ''shell "$SHELL" --block --confirm'';
            }
        ];
    };
}
