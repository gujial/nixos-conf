{
  pkgs,
  ...
}:

{
  home = {
    # 注意修改这里的用户名与用户目录
    username = "gujial";
    homeDirectory = "/home/gujial";

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

    sessionVariables = {
      LD_LIBRARY_PATH = /run/current-system/sw/share/nix-ld/lib;
      IDEA_VM_OPTIONS = "/home/gujial/jetbra/vmoptions/idea.vmoptions";
      CLION_VM_OPTIONS = "/home/gujial/jetbra/vmoptions/clion.vmoptions";
      PYCHARM_VM_OPTIONS = "/home/gujial/jetbra/vmoptions/pycharm.vmoptions";
      GOLAND_VM_OPTIONS = "/home/gujial/jetbra/vmoptions/goland.vmoptions";
      DATAGRIP_VM_OPTIONS = "/home/gujial/jetbra/vmoptions/datagrip.vmoptions";
      RUSTROVER_VM_OPTIONS = "/home/gujial/jetbra/vmoptions/rustrover.vmoptions";
      RIDER_VM_OPTIONS = "/home/gujial/jetbra/vmoptions/rider.vmoptions";
    };

    packages = with pkgs; [
      fastfetch
      gimp
      wechat-uos
      obs-studio
      qq
      mpv
      telegram-desktop
      obsidian
      adwsteamgtk
      osu-lazer-bin
      android-studio
      prismlauncher
      ventoy-full-qt
      piper
      fluent-reader
      nur.repos.xddxdd.dingtalk
      wemeet
      splayer
      darktable
      scanmem
      chromium
      yt-dlp
      scrcpy
      ffmpeg
      statix
      feishu
      python3
      wpsoffice-cn
      traceroute
      android-tools
      godot
      firefox-bin
      jadx
      protonplus
      gdb
      gcc
      jetbrains.idea
      cutter
      github-copilot-cli
      tmux

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

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.05";
  };
  programs = {

    vscode.enable = true;

    # git 相关配置
    git = {
      enable = true;
      signing.key = "DDC9F70191CA14A3";
      signing.signByDefault = true;
      lfs.enable = true;
      settings = {
        user.name = "gujial";
        user.email = "gu18647403665@outlook.com";
        safe.directory = "/etc/nixos";
      };
    };
  };
}
