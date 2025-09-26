{ inputs, ... }:
{
    imports = [
        inputs.git-hooks.flakeModule
    ];

    perSystem = {
        pre-commit.settings.hooks = {
            nixfmt-rfc-style = {
                enable = true;
                settings.width = 80;
                args = [ "--indent=4" ];
            };
        };
    };
}
