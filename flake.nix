{
  description = "A NixOS flake for pkharvey's personal computer.";

  inputs = {
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:/nixos/nixpkgs/nixos-unstable";
    nixinate.url = "github:matthewcroughan/nixinate";
    home-manager.url = "github:nix-community/home-manager";
    robotnix.url = "github:danielfullmer/robotnix";
    firefox = {
      url = "github:colemickens/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mobile-nixos = {
      url = "github:matthewcroughan/mobile-nixos/mc/latest-64";
      flake = false;
    };
    nur.url = "github:nix-community/nur";
    disko.url = "github:nix-community/disko";
    disko-utils.url = "github:matthewcroughan/disko-utils";
  };

  outputs = { self, nixpkgs, home-manager, robotnix, firefox, nixinate, nixos-hardware, mobile-nixos, nur, disko, disko-utils, ... }@inputs: {

    apps = nixinate.nixinate.x86_64-linux self;

    # Applies the function `robotnixSystem` to each of the attributes in the
    # set, for example `hlte`. This means I can have a set of phones to build.
    robotnixConfigurations = nixpkgs.lib.mapAttrs (n: v: inputs.robotnix.lib.robotnixSystem v) {
      brownstone = import ./hosts/brownstone/default.nix;
      #anotherPhone = import ./hosts/anotherPhone/default.nix;
    };

    packages.x86_64-linux = {
      pkhsts-autoinstaller-image = disko-utils.mkAutoInstaller self.nixosConfigurations.pkhsts;
    };

    nixosConfigurations = {
      prop6 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          (import "${mobile-nixos}/lib/configuration.nix" { device = "oneplus-enchilada"; })
          ./hosts/prop6/configuration.nix
          home-manager.nixosModules.home-manager
        ];
        specialArgs = { inherit inputs; };
      };
      pkhsts = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/pkhsts/configuration.nix
          disko.nixosModules.default
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.microsoft-surface-go
        ];
        specialArgs = {
          inherit inputs;
          device = "/dev/disk/by-id/nvme-eui.00080d01002dee2e";
        };
      };
      prodeskalpha = nixpkgs.lib.nixosSystem {    # this is the hostname = some func
        system = "x86_64-linux";
        modules = [
          (import ./hosts/prodeskalpha/configuration.nix)
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.common-cpu-intel
          {
            _module.args.nixinate = {
              host = "prodeskalpha";
              sshUser = "pasha";
              buildOn = "remote";
            };
          }
        ];
        specialArgs = { inherit inputs; };
      };
      newtoncrosby = nixpkgs.lib.nixosSystem {    # this is the hostname = some func
        system = "x86_64-linux";
        modules = [
          (import ./hosts/newtoncrosby/configuration.nix)
          home-manager.nixosModules.home-manager
          {
            _module.args.nixinate = {
              host = "newtoncrosby";
              sshUser = "pasha";
              buildOn = "remote";
            };
          }
        ];
        specialArgs = { inherit inputs; };
      };
      ptpx220 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (import ./hosts/ptpx220/configuration.nix)
          home-manager.nixosModules.home-manager
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}

