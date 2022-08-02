{ config, pkgs, lib, ... }:
{
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
    };
    pulse.enable = true;
  };
  environment.systemPackages = [
    pkgs.helvum
  ];
}

