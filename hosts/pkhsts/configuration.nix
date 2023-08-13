{ config, pkgs, inputs, ... }:
{
  imports = [
    ./disko.nix
    "${inputs.self}/mixins/bash.nix"
    "${inputs.self}/mixins/locale.nix"
    "${inputs.self}/mixins/workprogs.nix"
    "${inputs.self}/mixins/sway"
    "${inputs.self}/mixins/printing.nix"
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

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "pkhsts";
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  hardware.bluetooth.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 90;
  };

  system.stateVersion = "23.05";
}


