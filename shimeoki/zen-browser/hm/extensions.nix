{
    config,
    lib,
    ...
}:
let
    inherit (config.shimeoki) zen-browser;

    # source: https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file#extensions
    mkExtensionSettings = builtins.mapAttrs (
        _: pluginId: {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi"; # fix: pin version
            installation_mode = "force_installed";
        }
    );
in
{
    config = lib.mkIf zen-browser.enable {
        programs.zen-browser.policies = {
            ExtensionSettings = mkExtensionSettings {
                "uBlock0@raymondhill.net" = "ublock-origin";
            };
        };
    };
}
