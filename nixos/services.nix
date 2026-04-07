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
    };

    envfs.enable = true;
    openssh.enable = true;
    # services.gnome.gnome-keyring.enable = true;
    # security.pam.services.gdm.enableGnomeKeyring = true;
  };
}
