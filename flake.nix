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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
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
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      zen-browser,
      lanzaboote,
      nur,
      lazyvim-nix,
      cursor,
      re3-flake,
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

              home-manager.users.gujial = import ./home.nix;

              # 使用 home-manager.extraSpecialArgs 自定义传递给 ./home.nix 的参数
              # 取消注释下面这一行，就可以在 home.nix 中使用 flake 的所有 inputs 参数了
              # home-manager.extraSpecialArgs = inputs;
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
                  zen-browser.packages.${pkgs.system}.twilight
                  cursor.packages.${pkgs.system}.default
                  re3-flake.packages.${pkgs.system}.re3-vc
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
