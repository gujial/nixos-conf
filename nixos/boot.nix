# 引导加载程序与内核配置
# lanzaboote 模块由 flake.nix 注入，具体设置集中在此处
{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot = {
    loader = {
      # lanzaboote replaces the regular systemd-boot module.
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "hid_apple.fnmode=2"
      "snd_intel_dspcfg.dsp_driver=3"
    ];

    extraModulePackages = with config.boot.kernelPackages; [
      (v4l2loopback.overrideAttrs (old: {
        # Kernel installation generates depmod indexes that conflict with the
        # main kernel's indexes. NixOS regenerates these after merging modules.
        postInstall = (old.postInstall or "") + ''
          rm -f "$out/lib/modules/${config.boot.kernelPackages.kernel.modDirVersion}"/modules.*
        '';
      }))
    ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
