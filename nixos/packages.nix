# 系统级软件包
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    gnupg
    git
    unrar_6
    nvtopPackages.nvidia
    noto-fonts
    fira-code
    lshw
    asusctl
    wineWowPackages.waylandFull
    winetricks
    xsettingsd
    pinentry-curses
    usbutils
    quota
    rclone
  ];
}
