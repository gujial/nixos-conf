_:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # polkit agent
  security.soteria.enable = true;
  services = {

    # 给文件管理器提供预览缩略图的服务
    tumbler.enable = true;

    # 磁盘挂载
    gvfs.enable = true;

    # 让 Hyprland 而不是 logind 处理电源键
    logind.settings.Login = {
      HandlePowerKey = "ignore";
    };
  };
}
