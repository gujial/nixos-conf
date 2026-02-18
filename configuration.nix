# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  nix = {
    settings = {

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-substituters = [ "https://ai.cachix.org" ];
      trusted-public-keys = [ "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc=" ];
    };
  };
  hardware = {

    enableAllFirmware = true;

    bluetooth.enable = true;

    graphics.enable = true;
    nvidia = {
      open = false;
      modesetting.enable = true;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    nvidia-container-toolkit.enable = true;
  };
  virtualisation = {
    docker = {
      # Regular Docker
      daemon.settings.features.cdi = true;
      # Rootless
      rootless.daemon.settings.features.cdi = true;

      enable = true;
    };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
  };
  services = {
    xserver = {

      videoDrivers = [
        "modesetting"
        "nvidia"
      ];

      # Enable the X11 windowing system.
      # You can disable this if you're only using the Wayland session.
      enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "cn";
        variant = "";
      };
    };

    printing = {
      enable = true;
      browsed.enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "breeze";
      wayland.enable = true;
      enableHidpi = true;
      autoNumlock = true;
    };

    sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget

    asusd.enable = true;
    fwupd.enable = true;
    #   services.ollama = {
    #     enable = true;
    #     package = pkgs.ollama-cuda;
    #   };
    ratbagd.enable = true;
    xrdp = {
      defaultWindowManager = "startplasma-x11";
      enable = true;
      openFirewall = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  boot = {

    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "hid_apple.fnmode=2" ];
    #   boot.blacklistedKernelModules = [ "kvm-intel" ];

    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    initrd.systemd.enable = true;
  };
  networking = {

    hostName = "laptop-gu"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        25565
        7897
      ];
      trustedInterfaces = [ "Mihomo" ];
      checkReversePath = false;
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";
  i18n = {

    # Select internationalisation properties.
    defaultLocale = "zh_CN.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
    };

    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-gtk # alternatively, kdePackages.fcitx5-qt
        kdePackages.fcitx5-qt
        qt6Packages.fcitx5-chinese-addons # table input method support
      ];
      # fcitx5.waylandFrontend = true;
    };
  };
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  environment.systemPackages = with pkgs; [
    wget
    gnupg
    git
    unrar_6
    nvtopPackages.nvidia
    noto-fonts
    fira-code
    lshw
    asusctl
    wineWowPackages.waylandFull
    winetricks
    xsettingsd
    pinentry-curses
    usbutils
    quota
    rclone
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gujial = {
    isNormalUser = true;
    description = "gujial";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "gamemode"
      "adbusers"
      "libvirtd"
    ];
  };
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "agnoster";
        plugins = [
          "git"
          "z"
          "sudo"
          "extract"
        ];
      };

    };
    kdeconnect.enable = true;
    direnv.enable = true;
    partition-manager.enable = true;
    clash-verge = {
      enable = true;
      autoStart = true;
      serviceMode = true;
    };
    gamemode.enable = true;
    kde-pim = {
      enable = true;
      kmail = true;
      kontact = true;
    };

    appimage.enable = true;
    appimage.binfmt = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      package = pkgs.steam.override {
        extraPkgs = p: [
          p.kdePackages.breeze
        ];
      };
    };

    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      libadwaita
      gtk4
      glib
      pango
      cairo
      gdk-pixbuf
      atk
      harfbuzz
      fribidi
      gobject-introspection
      libGL
      stdenv.cc.cc.lib
      graphene
      wayland
      libxkbcommon
      libxshmfence
      pipewire
    ];
    virt-manager.enable = true;
  };
  nixpkgs = {
    # Allow unfree packages
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "ventoy-qt5-1.1.10"
      "openssl-1.1.1w"
      "mbedtls-2.28.10"
    ];
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      wqy_zenhei
      wqy_microhei
      hack-font
      source-code-pro
      jetbrains-mono
    ];
    fontconfig = {
      antialias = true;
      hinting.enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Noto Sans Mono CJK SC"
          "Sarasa Mono SC"
          "DejaVu Sans Mono"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
          "Source Han Sans SC"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif CJK SC"
          "Source Han Serif SC"
          "DejaVu Serif"
        ];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
