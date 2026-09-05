# 系统级软件包（包括来自 Flake inputs 的软件）
{ inputs, pkgs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  environment.systemPackages = [
    inputs.nix-auth.packages.${system}.default
    inputs.re3-flake.packages.${system}.reVC-Improved
    inputs.tinyMediaManager-flake.packages.${system}.default
    inputs.browser-previews.packages.${system}.google-chrome
    inputs.pfte-flake.packages.${system}.default
    inputs.creamlinux-installer.packages.${system}.default
    inputs.samrewritten.packages.${system}.default

    # Secure Boot diagnostics
    pkgs.sbctl
  ]
  ++ (with pkgs; [
    wget
    gnupg
    git
    cloudflared
    unrar
    nvtopPackages.nvidia
    noto-fonts
    fira-code
    lshw
    asusctl
    wineWow64Packages.waylandFull
    winetricks
    xsettingsd
    pinentry-curses
    usbutils
    quota
    rclone
    distrobox
  ]);
}
