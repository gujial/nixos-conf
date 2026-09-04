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
    libreoffice
    # nur.repos.xddxdd.baidunetdisk
    qpwgraph
    unzip
    net-tools
    pandoc
    ntfy-sh
    thunderbird
    pinentry-all
    gh
    imagemagick

    # 游戏
    adwsteamgtk
    osu-lazer-bin
    prismlauncher
    protonplus
    zeroad

    # 开发工具
    uv
    minicom
    zap
    jdk
    codex
    xxd
    # android-studio
    # jetbrains.idea
    # jetbrains.datagrip
    python3
    gcc
    gdb
    # godot
    github-copilot-cli
    cutter
    dotnet-sdk_10
    android-tools
    scrcpy
    statix
    scanmem
    file
    jadx
    apktool
    apksigner
    nodejs
    conda

    # 多媒体
    darktable
    splayer-next
    yt-dlp
    ffmpeg
    gimp

    # 系统工具
    scanmem
    piper
    ventoy-full-qt
    traceroute
    wl-clipboard

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
    kdePackages.sweeper
    kdePackages.ksystemlog
    kdePackages.sddm-kcm
    kdePackages.kpat
    kdePackages.neochat
    kdePackages.korganizer
    kdePackages.akonadi-calendar
    kdePackages.kunifiedpush
    okteta
    labplot
    krita
    kdePackages.akregator
  ];
}
