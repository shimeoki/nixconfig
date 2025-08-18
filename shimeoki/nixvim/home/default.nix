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
        ./diagnostics.nix
    ];

    options.shimeoki.nixvim = {
        enable = lib.mkEnableOption "nixvim" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.enable = true;
    };
}
