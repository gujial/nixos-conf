# Git 配置
_:

{
  programs.git = {
    enable = true;
    signing.key = "DDC9F70191CA14A3";
    signing.signByDefault = true;
    lfs.enable = true;
    settings = {
      user.name = "gujial";
      user.email = "gujial@gujial.cc";
      safe.directory = "/etc/nixos";
    };
  };
}
