# 用户会话环境变量
{ pkgs, ... }:

{
  home.sessionVariables = {
    LD_LIBRARY_PATH = /run/current-system/sw/share/nix-ld/lib;
    JAVA_HOME = "${pkgs.jdk}";
  };

  home.sessionPath = [
    "$HOME/.npm-global/bin"
    "$HOME/flutter/bin"
  ];
}
