# 字体配置
{ pkgs, ... }:

let
  tegakiZatsu = pkgs.stdenvNoCC.mkDerivation {
    pname = "tegaki-zatsu-font";
    version = "1.0";
    src = ../assets/fonts/tegaki_zatsu_normal.ttf;
    dontUnpack = true;
    installPhase = ''
      install -Dm644 $src $out/share/fonts/truetype/tegaki_zatsu_normal.ttf
    '';
  };
in
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      fira-code
      hack-font
      source-code-pro
      wqy_zenhei
      wqy_microhei
      corefonts
      tegakiZatsu
    ];

    fontDir.enable = true;

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "FiraCode Nerd Font Mono"
          "Noto Sans Mono CJK SC"
          "DejaVu Sans Mono"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
          "WenQuanYi Micro Hei"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif CJK SC"
          "WenQuanYi Zen Hei Sharp"
          "DejaVu Serif"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
