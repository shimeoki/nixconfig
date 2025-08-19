{ lib, inputs, ... }:
let
    # todo: root -> home after input update
    home = path: "${inputs.dotfiles}/root/${path}";
    config = path: home "private_dot_config/${path}";
    scripts = path: home "dot_scripts/${path}";
in
{
    options.shimeoki.dotfiles = with lib; {
        config = mkOption {
            type = with types; functionTo pathInStore;
        };
        scripts = mkOption {
            type = with types; functionTo pathInStore;
        };
    };

    config = {
        shimeoki.dotfiles = { inherit config scripts; };
    };
}
