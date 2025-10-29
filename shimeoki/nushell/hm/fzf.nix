{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config.shimeoki) nushell dotfiles fzf;

    # NOTE: the fzf module has many dependencies: niri, fd, bat, fzf, wl-copy,
    # cliphist and so on, because it tries to combine everything for fzf usage.
    # so right now it's preferred to enable this module only if you are sure
    # that everything is already installed or be sure to not use specific
    # commands (not really a solution). probably should be done dynamically
    # with not just importing a big module with everything, but with
    # separate files or just raw strings.
in
{
    config = lib.mkIf (nushell.enable && dotfiles.enable && fzf.enable) {
        # TODO: make separate modules for these programs
        home.packages = with pkgs; [
            cliphist
            imv
        ];

        programs.nushell = {
            extraConfig = ''
                use ${dotfiles.config "nushell/modules/fzf.nu"}
            '';

            settings.keybindings = with nushell; [
                (bind {
                    name = "fzf_edit";
                    keycode = "char_f";
                    event = {
                        send = "ExecuteHostCommand";
                        cmd = "fzf edit";
                    };
                })

                (bindShift {
                    name = "fzf_jump";
                    keycode = "char_f";
                    event = {
                        send = "ExecuteHostCommand";
                        cmd = "fzf jump";
                    };
                })

                (bind {
                    name = "fzf_copypath";
                    keycode = "char_t";
                    event = {
                        send = "ExecuteHostCommand";
                        cmd = "fzf copypath";
                    };
                })

                (bindShift {
                    name = "fzf_copyfile";
                    keycode = "char_t";
                    event = {
                        send = "ExecuteHostCommand";
                        cmd = "fzf copyfile";
                    };
                })
            ];
        };
    };
}
