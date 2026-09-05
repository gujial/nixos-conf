# 系统级程序配置
{ pkgs, ... }:

{
  programs = {
    ssh.extraConfig = ''
      Host forgejo-ssh.gujial.cc
        User git
        ProxyCommand ${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h
      Host *
    '';

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
    firejail.enable = false;

    gamemode.enable = true;

    kde-pim = {
      enable = true;
      kmail = true;
      kontact = true;
    };

    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
        extraPkgs = pkgs: [
          pkgs.libxshmfence
        ];
      };
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      package = pkgs.steam.override {
        extraPkgs = p: [ p.kdePackages.breeze ];
      };
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
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
        icu
        libGLU
        libx11
        libxext
      ];
    };

    virt-manager.enable = true;
    wireshark.enable = true;
    codexDesktopLinux.enable = true;
    # hyprland = {
    #   enable = true;
    #   withUWSM = true;
    #   xwayland.enable = true;
    # };
    # niri.enable = true;
  };
}
