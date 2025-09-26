{
    perSystem =
        { config, pkgs, ... }:
        let
            hooks = config.pre-commit;
        in
        {
            devShells = {
                default = pkgs.mkShell {
                    packages = [ pkgs.nushell ];
                    buildInputs = hooks.settings.enabledPackages;
                    shellHook = ''
                        ${hooks.installationScript}
                        exec nu
                    '';
                };
            };
        };
}
