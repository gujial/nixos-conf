{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
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
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    browser-previews = {
      url = "github:nix-community/browser-previews";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pfte-flake = {
      url = "github:gujial/pfte-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix/release-25.11";

    nix-auth.url = "github:numtide/nix-auth";

    claude-desktop = {
      url = "github:k3d3/claude-desktop-linux-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    codex-desktop-linux.url = "github:ilysenko/codex-desktop-linux";

    creamlinux-installer = {
      url = "github:gujial/creamlinux-installer-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    samrewritten = {
      url = "github:gujial/samrewritten-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      lanzaboote,
      nur,
      lazyvim-flake,
      plasma-manager,
      catppuccin,
      noctalia,
      codex-desktop-linux,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.laptop-gu = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix

          lanzaboote.nixosModules.lanzaboote
          lazyvim-flake.nixosModules.lazyvim
          codex-desktop-linux.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [ nur.overlays.default ];

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs; };
              users.gujial = import ./home.nix;
              sharedModules = [
                plasma-manager.homeModules.plasma-manager
                catppuccin.homeModules.catppuccin
                noctalia.homeModules.default
              ];
            };
          }
        ];
      };
    };
}
