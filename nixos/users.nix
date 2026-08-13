# 用户账户配置
{ pkgs, ... }:

{
  users.users.gujial = {
    isNormalUser = true;
    description = "gujial";
    shell = pkgs.zsh;
    extraGroups = [
      "wireshark"
      "networkmanager"
      "wheel"
      "docker"
      "gamemode"
      "adbusers"
      "libvirtd"
      "kvm"
      "video"
      "render"
      "uinput"
    ];
  };
}
