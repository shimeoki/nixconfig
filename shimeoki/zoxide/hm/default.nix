{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) zoxide dotfiles fzf;
in
{
    options.shimeoki.zoxide = {
        enable = lib.mkEnableOption "zoxide" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf zoxide.enable {
        home.sessionVariables = lib.mkIf (dotfiles.enable && fzf.enable) {
            _ZO_FZF_OPTS = lib.join " " [
                config.home.sessionVariables.FZF_DEFAULT_OPTS
                "--no-sort --height=100% --preview='fzf-preview.bash {2..}'"
            ];
        };

        programs.zoxide = {
            enable = true;
            enableNushellIntegration = false; # NOTE: managed by nushell module

            options = [ "--cmd=j" ];
        };
    };
}
