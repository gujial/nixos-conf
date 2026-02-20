# NixOS 系统配置入口
# 各功能模块位于 ./nixos/ 目录下
# 运行 `nixos-rebuild switch --flake .#laptop-gu` 以应用更改

{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    # 系统子模块
    ./nixos/boot.nix
    ./nixos/hardware.nix
    ./nixos/network.nix
    ./nixos/locale.nix
    ./nixos/audio.nix
    ./nixos/fonts.nix
    ./nixos/users.nix
    ./nixos/programs.nix
    ./nixos/services.nix
    ./nixos/plasma.nix
    ./nixos/packages.nix
  ];

  nix = {
    settings = {

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-substituters = [ "https://ai.cachix.org" ];
      trusted-public-keys = [ "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc=" ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "ventoy-qt5-1.1.10"
      "openssl-1.1.1w"
      "mbedtls-2.28.10"
    ];
  };

  system.stateVersion = "25.05";
}


