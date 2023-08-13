{ pkgs, inputs, ... }:
let
  sxmo = builtins.fetchGit {
    url = "https://github.com/wentam/sxmo-nix.git";
    rev = "74129afef2e5ebc874fc3b02bbda863c8c2a0cdc";
  };
in
{
  imports = [
    "${sxmo}/modules/sxmo"
    "${sxmo}/modules/tinydm"
  ];

  nixpkgs.overlays = [
    inputs.nur.overlay
  ];

  networking.networkmanager.enable = true;
  hardware.opengl.enable = true;

  services.xserver = {
    enable = true;
    desktopManager.sxmo.enable = true;
    desktopManager.sxmo.package = pkgs.nur.repos.colinsane.sxmo-utils;

    displayManager = {
      tinydm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "pasha";
      defaultSession = "swmo";
    };

    users.users.pasha = {
      extraGroups = [
        "dialout"
        "feedbackd"
        "networkmanager"
        "video"
        "wheel"
      ];
    };

  };
}
