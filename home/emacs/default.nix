# Emacs 配置模块
{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30;
    extraPackages = epkgs:
      with epkgs; [
        # 补全框架
        vertico
        orderless
        marginalia
        consult
        embark
        embark-consult

        # 编辑增强
        evil
        evil-collection
        general
        which-key
        avy

        # 项目管理
        projectile
        magit

        # LSP 支持
        lsp-mode
        lsp-ui
        company

        # 文件树
        treemacs
        treemacs-projectile
        treemacs-magit

        # 语言支持
        nix-mode
        markdown-mode
        yaml-mode
        rustic
        lsp-java
        go-mode

        # 主题
        catppuccin-theme
        doom-modeline
        all-the-icons
        nerd-icons

        # Org 模式
        org
        org-roam
        org-modern

        # 其他工具
        which-key
        helpful
        rainbow-delimiters
        smartparens
        undo-tree
        copilot
        copilot-chat
      ];
  };

  home.packages = with pkgs; [
      # Language Servers
        pyright
        clang-tools
        rust-analyzer
        jdt-language-server
        typescript-language-server
        nil
        gopls
        csharp-ls
  ];

  # 将 init.el 链接到 ~/.emacs.d/init.el
  home.file.".emacs.d/init.el".source = ./init.el;
  # 提前创建 early-init.el
  home.file.".emacs.d/early-init.el".source = ./early-init.el;
}
