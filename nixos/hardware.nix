# 硬件驱动、GPU 及虚拟化配置
{ pkgs, ... }:

{
  hardware = {
    enableAllFirmware = true;

    bluetooth.enable = true;

    graphics.enable = true;

    nvidia = {
      open = true;
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

    nvidia-container-toolkit.enable = false;
  };

  virtualisation = {
    spiceUSBRedirection.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
    };

    containers.registries.settings = {
      "unqualified-search-registries" = [ "docker.io" ];
    };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };

    waydroid = {
      enable = true;
      package = pkgs.waydroid-nftables;
    };
  };
}
