{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) nix-search-tv fzf;

    ns = pkgs.writeShellScriptBin "ns" (builtins.readFile ./nix-search-tv.bash);
in
{
    options.shimeoki.nix-search-tv = {
        enable = lib.mkEnableOption "nix-search-tv" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf (nix-search-tv.enable && fzf.enable) {
        home.packages = [ ns ];
        programs.nix-search-tv.enable = true;
    };
}
