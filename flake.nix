{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager, used for managing user coniguration
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lazyvim-nix = {
      url = "github:gujial/lazyvim-nix";
      # url = "path:/home/gujial/repos/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cursor = {
      url = "github:omarcresp/cursor-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    re3-flake = {
      url = "github:gujial/re3-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tinyMediaManager-flake = {
      url = "github:gujial/tinyMediaManager-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wechat-devtools.url = "github:MaikoTan/wechat-devtools";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      lanzaboote,
      nur,
      lazyvim-nix,
      cursor,
      re3-flake,
      tinyMediaManager-flake,
      wechat-devtools,
      ...
    }:
    {
      nixosConfigurations = {
        laptop-gu = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.nix

            lazyvim-nix.nixosModules.lazyvim

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              nixpkgs.overlays = [ nur.overlays.default ];
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.gujial = import ./home.nix;
            }

            lanzaboote.nixosModules.lanzaboote
            (
              { pkgs, lib, ... }:
              {
                environment.systemPackages = [
                  # For debugging and troubleshooting Secure Boot.
                  pkgs.sbctl
                ];

                # Lanzaboote currently replaces the systemd-boot module.
                # This setting is usually set to true in configuration.nix
                # generated at installation time. So we force it to false
                # for now.
                boot.loader.systemd-boot.enable = lib.mkForce false;

                boot.lanzaboote = {
                  enable = true;
                  pkiBundle = "/var/lib/sbctl";
                };
              }
            )

            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  nur.overlays.default
                ];

                environment.systemPackages = [
                  cursor.packages.${pkgs.stdenv.hostPlatform.system}.default
                  re3-flake.packages.${pkgs.stdenv.hostPlatform.system}.re3-vc
                  tinyMediaManager-flake.packages.${pkgs.stdenv.hostPlatform.system}.default
                  wechat-devtools.packages.${pkgs.stdenv.hostPlatform.system}.default
                ];
              }
            )

            (
              { pkgs, ... }:
              {
                fonts.packages = [
                  pkgs.nur.repos.rewine.ttf-wps-fonts
                  pkgs.nur.repos.rewine.ttf-ms-win10
                ];
              }
            )
          ];
        };
      };
    };
}
