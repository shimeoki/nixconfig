{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config.shimeoki) kitty;
in
{
    # todo: options

    config = lib.mkIf kitty.enable {
        programs.kitty = {
            font = {
                # hack: otherwise stylix doesn't work
                # better to specify in stylix config
                package = lib.mkForce pkgs.nerd-fonts.fira-code;
                name = lib.mkForce "FiraCode Nerd Font";
                size = 12;
            };
            settings = {
                disable_ligatures = "always";

                "modify_font underline_position" = 4;
                "modify_font underline_thickness" = "150%";
                "modify_font strikethrough_position" = -2;
            };
        };
    };
}
