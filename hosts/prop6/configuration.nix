{ config, pkgs, inputs, ... }:
{
  imports = [
    "${inputs.self}/mixins/bash.nix"
    "${inputs.self}/mixins/locale.nix"
    "${inputs.self}/mixins/workprogs.nix"
    "${inputs.self}/mixins/editor/nvim.nix"
    "${inputs.self}/mixins/audio.nix"
    "${inputs.self}/mixins/users/pasha.nix"
    "${inputs.self}/mixins/users/disableMutableUsers.nix"
    "${inputs.self}/mixins/common.nix"
    "${inputs.self}/mixins/tailscale.nix"
    "${inputs.self}/mixins/openssh.nix"
    "${inputs.self}/mixins/ssh/sk_keys.nix"
    "${inputs.self}/mixins/zram.nix"
  ];

  # OnePlus Firmware is unfree
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "prop6";
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  hardware.bluetooth.enable = true;


  # https://github.com/tailscale/tailscale/issues/3310
  # https://github.com/tailscale/tailscale/issues/4432
  networking.firewall.enable = false;

  system.stateVersion = "23.05";
}


