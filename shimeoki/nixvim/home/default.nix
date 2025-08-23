{
    config,
    lib,
    inputs,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.nixvim;
in
{
    imports = [
        inputs.nixvim.homeModules.nixvim
        ./plugins
        ./languages
        ./diagnostics.nix
        ./keymap.nix
        ./binds.nix
        ./opts.nix
        ./performance.nix
        ./clipboard.nix
        ./aliases.nix
    ];

    options.shimeoki.nixvim = {
        enable = lib.mkEnableOption "nixvim" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim = {
            enable = true;
            defaultEditor = true;
        };
    };
}
