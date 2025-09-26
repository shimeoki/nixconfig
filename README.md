# nixconfig

My [NixOS](https://nixos.org/) configuration as a flake.

The configuration is in very early state, but should be fully usable with the
sufficient host and user configuration, even for non-NixOS machines.

## Description

It is planned to be a Nix counterpart of my
[dotfiles](https://github.com/shimeoki/dotfiles). Most of the configuration is
just mirrored, but written in Nix, where possible.

For the philosophy of the configuration, visuals, applications and so on, check
the repository above.

But there are still some differences:

- The coverage is not full.
- Some additional configuration is present specific to Nix(OS).
- The theme is defined via [Stylix](https://github.com/nix-community/stylix).

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

## Usage

### Full

If you want to fully transition to this configuration, you need to clone the
configuration

```sh
git clone https://github.com/shimeoki/nixconfig.git
```

and define your own hosts and users as needed. Then, add them in the
`flake.nix`, as can be already seen in the flake itself.

Some notes:

- Don't forget to add new files to Git.
- If your system is not `x86_64-linux`, change the `systems.url` in `flake.nix`.

### Partial

The flake doesn't expose the modules for external usage in a flake yet.

## Contributing

The flake exposes a development shell (with Nushell). If Nix is installed, in
the directory of the flake run

```sh
nix develop
```

to use pre-commit hooks with formatting.

The style is not very strict, but general guidelines are:

- 4 spaces per tab and 80 columns maximum.
- Conventional commits for the commits.
