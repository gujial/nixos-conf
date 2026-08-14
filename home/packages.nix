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
    element-desktop
    nur.repos.xddxdd.baidunetdisk
    qpwgraph
    unzip
    net-tools
    pandoc
    ntfy-sh
    thunderbird
    pinentry-all
    cisco-packet-tracer_9
    haguichi
    gh

    # 游戏
    adwsteamgtk
    osu-lazer-bin
    prismlauncher
    protonplus
    zeroad

    # 开发工具
    proxypin
    zap
    jdk
    wireshark
    github-copilot-cli
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
    jadx
    apktool
    apksigner

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
    supergfxctl-plasmoid
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
