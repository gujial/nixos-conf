# Git 配置
{ ... }:

{
  programs.git = {
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
}
