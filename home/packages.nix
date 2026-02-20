# Home Manager 用户软件包
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # 日常应用
    fastfetch
    gimp
    wechat-uos
    obs-studio
    qq
    mpv
    telegram-desktop
    obsidian
    fluent-reader
    chromium
    firefox-bin
    feishu
    wpsoffice-cn

    # 游戏
    adwsteamgtk
    osu-lazer-bin
    prismlauncher
    protonplus

    # 开发工具
    android-studio
    jetbrains.idea
    python3
    gcc
    gdb
    godot
    github-copilot-cli
    cutter
    jadx
    android-tools
    scrcpy
    tmux
    statix
    scanmem
    emacs

    # 多媒体
    darktable
    splayer
    yt-dlp
    ffmpeg

    # 系统工具
    piper
    ventoy-full-qt
    traceroute
    wemeet
    nur.repos.xddxdd.dingtalk

    # KDE 应用
    kdePackages.spectacle
    kdePackages.kcalc
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
    kdePackages.discover
  ];
}
