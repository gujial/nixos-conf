# 硬件驱动、GPU 及虚拟化配置
{ pkgs, ... }:

{
  hardware = {
    enableAllFirmware = true;

    bluetooth.enable = true;

    graphics.enable = true;

    nvidia = {
      open = false;
      modesetting.enable = true;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    nvidia-container-toolkit.enable = true;
  };

  virtualisation = {
    docker = {
      daemon.settings.features.cdi = true;
      rootless.daemon.settings.features.cdi = true;
      enable = true;
    };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
    waydroid = {
      enable = false;
      package = pkgs.waydroid-nftables;
    };
  };
}
