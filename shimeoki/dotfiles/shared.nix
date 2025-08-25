{
    pkgs,
    lib,
    inputs,
    ...
}:
let
    home = path: "${inputs.dotfiles}/home/${path}";
    config = path: home "private_dot_config/${path}";

    scripts = pkgs.stdenv.mkDerivation {
        name = "dotfiles-scripts";
        src = home "dot_scripts";

        installPhase = ''
            mkdir -p $out/bin
            for file in "$src"/executable_*; do
                old_name=$(basename "$file")
                new_name=''${old_name#executable_} # remove prefix
                path="$out/bin/$new_name"
                cp "$file" "$path"
                chmod +x "$path"
            done
        '';
    };
in
{
    options.shimeoki.dotfiles = with lib; {
        config = mkOption {
            type = with types; functionTo pathInStore;
        };

        scripts = mkOption {
            type = types.package;
        };
    };

    config = {
        shimeoki.dotfiles = { inherit config scripts; };
    };
}
