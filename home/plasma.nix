# KDE Plasma 用户级设置（由 plasma-manager 管理）
# 文档：https://github.com/nix-community/plasma-manager
# 此模块需要在 flake.nix 中引入 plasma-manager.homeManagerModules.plasma-manager
{ ... }:

{
  programs.plasma = {
    # ── 工作区外观 ──────────────────────────────────────────────
    workspace = {
      # 颜色方案：使用 Breeze Dark
      colorScheme = "BreezeDark";
      # 桌面主题
      theme = "breeze-dark";
      # 光标主题
      cursor.theme = "breeze_cursors";
      # 图标主题
      iconTheme = "breeze-dark";
      # 壁纸图片路径
      wallpaper = "/home/gujial/图片/e080ee89f0b6a8ecb588e0314a3fbc30332857493.jpg";
    };

    # ── 字体 ─────────────────────────────────────────────────────
    fonts = {
      general = {
        family = "Noto Sans CJK SC";
        pointSize = 11;
      };
      fixedWidth = {
        family = "FiraCode Nerd Font";
        pointSize = 11;
      };
      small = {
        family = "Noto Sans CJK SC";
        pointSize = 9;
      };
      toolbar = {
        family = "Noto Sans CJK SC";
        pointSize = 11;
      };
      menu = {
        family = "Noto Sans CJK SC";
        pointSize = 11;
      };
      windowTitle = {
        family = "Noto Sans CJK SC";
        pointSize = 11;
      };
    };

    # ── 快捷键 ─────────────────────────────────────────────────
    shortcuts = {
      "kitty.desktop"._launch = "Ctrl+Alt+T";
    };
  };
}
