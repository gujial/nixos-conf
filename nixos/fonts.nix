# 字体配置
{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      fira-code
      hack-font
      source-code-pro
      # jetbrains-mono
      wqy_zenhei
      wqy_microhei
      corefonts
    ];

    fontDir.enable = true;

    fontconfig = {
      enable = true;
      defaultFonts = {
        # 等宽字体 (终端/编辑器用)
        monospace = [
          "FiraCode Nerd Font Mono"
          "Noto Sans Mono CJK SC"
          "DejaVu Sans Mono"
        ];

        # 无衬线字体 (系统界面/网页主要用)
        sansSerif = [
          "Noto Sans CJK SC"
          "WenQuanYi Micro Hei"
          "DejaVu Sans"
        ];

        # 衬线字体 (文档/阅读用)
        serif = [
          "Noto Serif CJK SC"
          "WenQuanYi Zen Hei Sharp"
          "DejaVu Serif"
        ];

        # Emoji 字体
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
