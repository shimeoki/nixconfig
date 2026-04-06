# nixconfig

My [NixOS](https://nixos.org/) configuration as a flake.

## Notice

This configuration is superseded by
[system (on codeberg)](https://codeberg.org/shimeoki/system).

The repository is archived, not recommended for usage and preserved for history.

## Description

It is planned to be a Nix counterpart of my
[dotfiles](https://github.com/shimeoki/dotfiles). Most of the configuration is
just mirrored, but written in Nix, where possible.

## Structure

### Modules

The flake uses the "vanilla" Nix module system with options. All modules are
contained under the `shimeoki` "namespace" (attribute).

Modules are divided into directories per application or some specific purpose.
The modules are exposing both
[Home Manager](https://github.com/nix-community/home-manager) and NixOS options
in sub-directories.

So, the structure is `shimeoki/<app>/<platform>/default.nix` for an application.
Corresponding platforms are exposed in `shimeoki/<platform>.nix`. Everything
else is decided per module. Generally, sub-levels (nested attributes) are nested
in directories to reflect this.

The modules follow a "cascade enabling" pattern - if the upper level is enabled,
then the lower enabled is enabled automatically, if not disabled explicitly.

With this approach you can enable the top-level `shimeoki` module to enable
everything, or enable just `shimeoki.nixvim` (any specific module) as you
desire.

### Hosts and users

To use the modules, the flake uses `hosts` and `users`.

Host is a module, where all configuration specific to the machine should be:
filesystem, network, kernel, keyboard, bootloader, etc.. Also, this module
should activate all needed NixOS `shimeoki` modules, not related to the user.

User is a module, where all the other configuration should be. It is a NixOS
module, and then it imports Home Manager. Because some options can be specific
to a user, but not configured at Home Manager level, they should be done here.

Examples for both can be seen in the flake.
