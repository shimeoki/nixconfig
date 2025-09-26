let
    name = "shimeoki-nixconfig-fmt";
in
{
    perSystem =
        { config, pkgs, ... }:
        let
            hooks = config.pre-commit.settings;
        in
        {
            formatter = pkgs.writeShellScriptBin name ''
                ${hooks.package}/bin/pre-commit run --all-files \
                    --config ${hooks.configFile}
            '';
        };
}
