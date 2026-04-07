# 网络、防火墙与代理配置
_:

{
  networking = {
    hostName = "laptop-gu";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        25565 # Minecraft
        7897 # Mihomo/代理
        5244
        22
      ];
      trustedInterfaces = [
        "Mihomo"
        "waydroid0"
      ];
      checkReversePath = false;
    };
  };
}
