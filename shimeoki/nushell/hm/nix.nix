{ config, lib, ... }:
let
    inherit (config.shimeoki) nushell git;
in
{
    config = lib.mkIf (nushell.enable && git.enable) {
        programs.nushell.extraConfig = ''
            def pkg [name: string] { nix shell $"nixpkgs#($name)" }
        '';
    };
}
