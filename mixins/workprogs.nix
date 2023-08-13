{ config, pkgs, lib, inputs, ...}:
{
  home-manager.users.pasha = { pkgs, ... }: {
    home.packages = with pkgs; [
      libreoffice
      gimp
      inkscape
      kicad-small

      element-desktop

      logseq
      leafpad
      free42
      feh
      zathura

      pulsemixer
      pavucontrol

      vlc
      youtube-dl
      wget
      ffmpeg
      mpv

      ruby

      btop
      iotop
      sysstat

      magic-wormhole
      man-pages
      tree
      file
      lsof
      psmisc
      zip
      unzip
      ripgrep
      fd
      hyperfine

      picocom
    ];
  };
}
