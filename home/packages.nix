# Home Manager 用户软件包
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # 日常应用
    fastfetch
    wechat
    mpv
    telegram-desktop
    obsidian
    feishu
    libreoffice
    bitwarden-desktop
    nur.repos.xddxdd.dingtalk
    nur.repos.xddxdd.baidunetdisk

    # 游戏
    adwsteamgtk
    osu-lazer-bin
    prismlauncher
    protonplus

    # 开发工具
    xxd
    android-studio
    jetbrains.idea
    jetbrains.datagrip
    python3
    gcc
    gdb
    godot
    github-copilot-cli
    cutter
    dotnet-sdk_10
    android-tools
    scrcpy
    statix
    scanmem
    qtcreator
    file

    (callPackage ./nvimunity/nvimunity.nix { })

    (pkgs.unityhub.override {
      extraLibs =
        pkgs: with pkgs; [
          fcitx5-gtk
          noto-fonts-cjk-sans
          wqy_zenhei
          sarasa-gothic
        ];
    })

    nodejs
    conda

    # 多媒体
    darktable
    splayer
    yt-dlp
    ffmpeg
    scanmem
    gimp

    # 系统工具
    piper
    ventoy-full-qt
    traceroute
    wemeet

    # KDE 应用
    kdePackages.spectacle
    kdePackages.kcalc
    kdePackages.krdc
    kdePackages.filelight
    kdePackages.isoimagewriter
    kdePackages.kmousetool
    kdePackages.kdenlive
    kdePackages.kamoso
    kdePackages.krecorder
    kdePackages.kwave
    supergfxctl-plasmoid
    kdePackages.sweeper
    kdePackages.ksystemlog
    kdePackages.sddm-kcm
    kdePackages.kpat
    kdePackages.neochat
    kdePackages.korganizer
    kdePackages.akonadi-calendar
    okteta
    labplot
    krita
  ];
}
