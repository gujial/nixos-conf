{
  config,
  lib,
  pkgs,
  ...
}:

{
  # 注意修改这里的用户名与用户目录
  home.username = "gujial";
  home.homeDirectory = "/home/gujial";

  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # 递归将某个文件夹中的文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # 递归整个文件夹
  #   executable = true;  # 将其中所有文件添加「执行」权限
  # };

  # 直接以 text 的方式，在 nix 配置文件中硬编码文件内容
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装

  home.sessionVariables = {
    LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib/";
    IDEA_VM_OPTIONS="/home/gujial/jetbra/vmoptions/idea.vmoptions";
    CLION_VM_OPTIONS="/home/gujial/jetbra/vmoptions/clion.vmoptions";
    PYCHARM_VM_OPTIONS="/home/gujial/jetbra/vmoptions/pycharm.vmoptions";
    GOLAND_VM_OPTIONS="/home/gujial/jetbra/vmoptions/goland.vmoptions";
    DATAGRIP_VM_OPTIONS="/home/gujial/jetbra/vmoptions/datagrip.vmoptions";
    RUSTROVER_VM_OPTIONS="/home/gujial/jetbra/vmoptions/rustrover.vmoptions";
    RIDER_VM_OPTIONS="/home/gujial/jetbra/vmoptions/rider.vmoptions";
  };

  home.packages = with pkgs; [
    tmux
    fastfetch
    gimp
    wechat
    obs-studio
    qq
    mpv
    vscode
    telegram-desktop
    obsidian
    adwsteamgtk
    osu-lazer-bin
    android-studio
    prismlauncher
    ventoy-full-qt
    projectlibre
    piper
    fluent-reader
    nixfmt-rfc-style
    nur.repos.xddxdd.dingtalk
    wemeet
    qbittorrent
    blesh
    pinentry
    wpsoffice-cn
    splayer

    jetbrains.clion
    jetbrains.goland
    jetbrains.rust-rover
    jetbrains.datagrip
    jetbrains.rider
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate

    kdePackages.spectacle
    kdePackages.kdenlive
    kdePackages.kcalc
    kdePackages.filelight
    kdePackages.isoimagewriter
    kdePackages.kmousetool
    okteta
    kdePackages.kamoso
    kdePackages.krecorder
    kdePackages.kwave
    supergfxctl-plasmoid
    kdePackages.discover
    kdiff3
  ];

  # git 相关配置
  programs.git = {
    enable = true;
    settings.user.name = "gujial";
    settings.user.email = "gu18647403665@outlook.com";
    signing.key = "DDC9F70191CA14A3";
    signing.signByDefault = true;
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      [[ $- == *i* ]] && source -- "$(blesh-share)"/ble.sh --attach=none
      [[ ! ''${BLE_VERSION-} ]] || ble-attach
    '';
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
