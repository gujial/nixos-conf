{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swaybg
    waypaper
    hyprlock
    swaylock-effects
    swayidle
    wlogout
    wlsunset
    fuzzel
    waybar
    uwsm
    xwayland-satellite
    file-roller
    loupe
    papers
    adwaita-icon-theme
    gnome-themes-extra
    yazi
    wofi
  ];
  services = {

    # 调整亮度音量显示
    avizo.enable = true;

    # 通知显示
    swaync.enable = true;

    # 根据不同的设备加载不同的显示器分辨率刷新率缩放
    # 就不用去 wm 里面一个一个配，导致每次换设备都要修改配置
    # https://wiki.archlinux.org/title/Kanshi
    # kanshi.enable = true;

    # 壁纸软件
    # wpaperd = {
    #   enable = true;
    #   settings = {
    #     default = {
    #       duration = "30m";
    #       mode = "center";
    #     };
    #     any.path = "${config.home.homeDirectory}/Pictures";
    #   };
    # };
  };
}
