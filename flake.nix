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

    re3-flake = {
      url = "github:gujial/re3-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tinyMediaManager-flake = {
      url = "github:gujial/tinyMediaManager-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lazyvim-flake = {
      url = "github:gujial/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wechat-devtools.url = "github:MaikoTan/wechat-devtools";
    txdedit.url = "github:gujial/txdedit";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      lanzaboote,
      nur,
      re3-flake,
      tinyMediaManager-flake,
      wechat-devtools,
      txdedit,
      lazyvim-flake,
      plasma-manager,
      ...
    }:
    {
      nixosConfigurations = {
        laptop-gu = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.gujial = import ./home.nix;
                sharedModules = [
                  plasma-manager.homeModules.plasma-manager
                ];
              };
              nixpkgs.overlays = [ nur.overlays.default ];
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

            lazyvim-flake.nixosModules.lazyvim

            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  nur.overlays.default
                ];

                environment.systemPackages = [
                  re3-flake.packages.${pkgs.stdenv.hostPlatform.system}.reVC-Improved
                  tinyMediaManager-flake.packages.${pkgs.stdenv.hostPlatform.system}.default
                  txdedit.packages.${pkgs.stdenv.hostPlatform.system}.default
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
