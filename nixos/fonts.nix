# 字体配置
{ pkgs, ... }:

let
  localAssetFonts = pkgs.runCommandLocal "local-asset-fonts" { } ''
    mkdir -p $out/share/fonts/truetype
    cp -r ${../assets/fonts}/. $out/share/fonts/truetype/
  '';
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
      maple-mono.truetype
      maple-mono.NF-unhinted
      maple-mono.NF-CN-unhinted
      fira-code
      hack-font
      source-code-pro
      wqy_zenhei
      wqy_microhei
      corefonts
      localAssetFonts
    ];

    fontDir.enable = true;

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "Maple Mono"
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
