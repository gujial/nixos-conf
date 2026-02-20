# 用户账户配置
{ pkgs, ... }:

{
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
}
