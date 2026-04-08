{ pkgs, ... }:
{
  programs.fuzzel.enable = true;
  catppuccin.fuzzel = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";
  };
  services = {

    polkit-gnome.enable = true; # 权限认证

    # 消息通知
    swaync.enable = true;
    swayidle.enable = true;
  };
  catppuccin.swaync = {
    enable = true;
    flavor = "mocha";
  };

  # services.mako.enable = true;
  # catppuccin.mako = {
  #   enable = true;
  #   accent = "mauve";
  #   flavor = "mocha";
  # };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "image/png" = [ "imv.desktop" ];
    "image/jpeg" = [ "imv.desktop" ];
    "image/gif" = [ "imv.desktop" ];
    "text/html" = "google-chrome.desktop";
    "x-scheme-handler/http" = "google-chrome.desktop";
    "x-scheme-handler/https" = "google-chrome.desktop";
    "x-scheme-handler/clash" = "clash-verge.desktop";
  };
  home = {

    # 光标配置
    pointerCursor = {
      enable = true;
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };

    packages = with pkgs; [
      imv
      yazi
      xwayland-satellite
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PATH = "$HOME/.local/bin:$PATH";
      LANG = "zh_CN.UTF-8";
      LC_CTYPE = "zh_CN.UTF-8";
      LC_MESSAGES = "zh_CN.UTF-8";
    };

    file.".config/niri/config.kdl".source = ./config.kdl;
  };
}
