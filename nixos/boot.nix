# 引导加载程序与内核配置
# lanzaboote（Secure Boot）由 flake.nix 注入，会强制覆盖 systemd-boot
{ config, pkgs, ... }:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "hid_apple.fnmode=2" ];

    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    initrd.systemd.enable = true;
  };
}
