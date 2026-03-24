# 系统级软件包
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    gnupg
    git
    unrar
    nvtopPackages.nvidia
    noto-fonts
    fira-code
    lshw
    asusctl
    wineWow64Packages.waylandFull
    winetricks
    xsettingsd
    pinentry-curses
    usbutils
    quota
    rclone
  ];
}
