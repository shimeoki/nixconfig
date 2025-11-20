{ inputs, pkgs, ... }:
let
    name = "d";
in
{
    imports = [
        inputs.self.nixosModules.shimeoki # note: imports home-manager module
    ];

    users.users."${name}" = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "networkmanager"
        ];
    };

    shimeoki = {
        nushell.users = [ name ];
        greetd.user = name;
    };

    fonts.packages = with pkgs; [
        # keep-sorted start
        fira-code
        nerd-fonts.fira-code
        nerd-fonts.noto
        nerd-fonts.roboto-mono
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        noto-fonts-lgc-plus
        roboto
        roboto-mono
        # keep-sorted end
    ];

    home-manager.users."${name}" = ./hm;
}
