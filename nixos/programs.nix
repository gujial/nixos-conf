# 系统级程序配置
{ pkgs, ... }:

{
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

    # clash-verge = {
    #   enable = true;
    # };

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

    weylus = {
      enable = true;
      openFirewall = true;
      users = [ "gujial" ];
    };

    virt-manager.enable = true;
    wireshark.enable = true;
    # hyprland = {
    #   enable = true;
    #   withUWSM = true;
    #   xwayland.enable = true;
    # };
    # niri.enable = true;
  };
}
