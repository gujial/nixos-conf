# Kitty 终端模拟器配置
# 文档：https://sw.kovidgoyal.net/kitty/conf/
# Home Manager 选项：https://nix-community.github.io/home-manager/options.xhtml#opt-programs.kitty.enable
_:

{
  programs.kitty = {
    enable = true;

    # 字体
    font = {
      name = "JetBrains Mono";
      size = 11;
    };

    # 主题（需在 themeFile 中选择，或直接用内置主题名）
    # 可通过 `kitty +kitten themes` 浏览所有主题
    themeFile = "Ghostty_Default"; # 使用 Ghostty Default 主题

    # 终端设置
    settings = {
      # 透明度（0.0 - 1.0）
      background_opacity = "0.7";

      # 模糊度
      background_blur = "30";

      # 关闭确认对话框（0 = 不确认）
      confirm_os_window_close = 0;

      # 禁用系统提示音
      enable_audio_bell = false;

      # 滚动缓冲区行数
      scrollback_lines = 10000;

      # 选中文字自动复制到剪贴板
      copy_on_select = "no";

      # Tab 栏样式
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      # 使用 Wayland 协议
      linux_display_server = "wayland";

      remember_window_size = "no";
      initial_window_width = 1280;
      initial_window_height = 720;
    };

    # Shell 集成（自动与 zsh 集成，提供 jump、clone-in-kitty 等功能）
    shellIntegration.enableZshIntegration = true;

    # 快捷键映射
    keybindings = {
      # 新标签页
      "ctrl+t" = "new_tab_with_cwd";
      # 水平分割
      "ctrl+shift+minus" = "launch --location=hsplit --cwd=current";
      # 垂直分割
      "ctrl+shift+backslash" = "launch --location=vsplit --cwd=current";
      # 窗格导航
      "ctrl+shift+h" = "neighboring_window left";
      "ctrl+shift+l" = "neighboring_window right";
      "ctrl+shift+k" = "neighboring_window top";
      "ctrl+shift+j" = "neighboring_window bottom";
    };
  };
}
