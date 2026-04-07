# Home Manager 配置入口
# 各功能模块位于 ./home/ 目录下
#
# 注意：plasma.nix 需要 flake.nix 中引入 plasma-manager
# kitty.nix 使用内置 Home Manager programs.kitty 模块

{
  ...
}:

{
  imports = [
    ./home/packages.nix
    ./home/variables.nix
    ./home/git.nix
    ./home/vscode.nix
    ./home/kitty.nix
    ./home/tmux.nix
    ./home/plasma.nix
    ./home/programs.nix
    # ./home/hyprland
  ];

  home = {
    username = "gujial";
    homeDirectory = "/home/gujial";
    stateVersion = "26.05";
  };
}
