# 网络、防火墙与代理配置
_:

{
  networking = {
    hostName = "laptop-gu";
    networkmanager.enable = true;

    firewall = {
      enable = false;
      allowedTCPPorts = [
        25565 # Minecraft
        7897 # Mihomo/代理
        5244
        22
      ];
      allowedUDPPorts = [
        43593
      ];
      trustedInterfaces = [
        "Mihomo"
        "waydroid0"
        "zttqhrscua"
      ];
      checkReversePath = false;
    };
  };
}
