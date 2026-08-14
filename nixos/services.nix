# 系统服务配置
{ pkgs, ... }:

{
  services = {
    printing = {
      enable = true;
      browsed.enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };

    asusd.enable = true;
    fwupd.enable = true;
    ratbagd.enable = true;

    xrdp = {
      enable = true;
      defaultWindowManager = "startplasma-x11";
      openFirewall = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      allowInterfaces = [
        "zttqhrscua"
        "wlo1"
      ];
    };

    mihomo = {
      enable = true;
      configFile = "/home/gujial/config.yaml";
      tunMode = true;
    };

    sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };

    envfs.enable = true;
    openssh.enable = true;
    logmein-hamachi.enable = false;
    # cloudflare-warp.enable = true;
    # kubo = {
    #   enable = true;
    #   settings = {
    #     Addresses.Gateway = "https://ipfs.gujial.cc";
    #   };
    # };
    # # ntfy-sh = {
    #   enable = true;
    #   settings = {
    #     base-url = "https://api.u266198.nyat.app:16767";
    #   };
    # };
  };
}
