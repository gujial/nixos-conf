;;; init.el --- Emacs 主配置文件 -*- lexical-binding: t; -*-

;;; ============================================================
;;; 基础设置
;;; ============================================================

;; 启动后恢复 GC 阈值
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024))))

;; 基础 UI
(setq inhibit-startup-message t
      visible-bell t
      use-dialog-box nil)

(column-number-mode 1)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)

;; 字体
;; 主字体（英文 / 代码）
(set-face-attribute 'default nil :font "Hack" :height 110)
;; 中文字体
(set-fontset-font t 'han (font-spec :family "Noto Sans CJK SC"))

;; 编码
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; 自动保存 / 备份
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; 缩进
(setq-default indent-tabs-mode nil
              tab-width 4)

;; 滚动
(setq scroll-conservatively 101
      scroll-margin 5)

;;; ============================================================
;;; 主题
;;; ============================================================

(require 'catppuccin-theme)
(setq catppuccin-flavor 'mocha)
(load-theme 'catppuccin :no-confirm)

(require 'doom-modeline)
(doom-modeline-mode 1)
(setq doom-modeline-icon t
      doom-modeline-height 25)

(require 'nerd-icons)

;;; ============================================================
;;; Evil 模式（Vim 键位）
;;; ============================================================

(setq evil-want-integration t
      evil-want-keybinding nil
      evil-want-C-u-scroll t
      evil-undo-system 'undo-tree)
(require 'evil)
(evil-mode 1)

(require 'evil-collection)
(evil-collection-init)

(require 'undo-tree)
(global-undo-tree-mode)

;;; ============================================================
;;; 按键绑定（general.el）
;;; ============================================================

(require 'general)
(general-evil-setup t)

(general-create-definer my/leader-keys
  :keymaps '(normal insert visual emacs)
  :prefix "SPC"
  :global-prefix "C-c SPC")

(my/leader-keys
  ;; 文件
  "f"  '(:ignore t :which-key "文件")
  "ff" '(find-file :which-key "打开文件")
  "fs" '(save-buffer :which-key "保存")
  "fr" '(consult-recent-file :which-key "最近文件")
  ;; 缓冲区
  "b"  '(:ignore t :which-key "缓冲区")
  "bb" '(consult-buffer :which-key "切换缓冲区")
  "bk" '(kill-this-buffer :which-key "关闭缓冲区")
  ;; 项目
  "p"  '(:ignore t :which-key "项目")
  "pp" '(projectile-switch-project :which-key "切换项目")
  "pf" '(projectile-find-file :which-key "项目文件")
  ;; Git
  "g"  '(:ignore t :which-key "Git")
  "gs" '(magit-status :which-key "Magit 状态")
  ;; 搜索
  "s"  '(:ignore t :which-key "搜索")
  "ss" '(consult-line :which-key "行搜索")
  "sr" '(consult-ripgrep :which-key "全局搜索")
  ;; 帮助
  "h"  '(:ignore t :which-key "帮助")
  "hf" '(helpful-callable :which-key "函数文档")
  "hv" '(helpful-variable :which-key "变量文档")
  "hk" '(helpful-key :which-key "按键文档")
  ;; 窗口
  "w"  '(:ignore t :which-key "窗口")
  "wv" '(split-window-right :which-key "垂直分割")
  "ws" '(split-window-below :which-key "水平分割")
  "wk" '(delete-window :which-key "关闭窗口")
  "ww" '(other-window :which-key "切换窗口")
  ;; 树形目录
  "e"  '(treemacs :which-key "文件树")
  ;; Org
  "o"  '(:ignore t :which-key "Org")
  "oa" '(org-agenda :which-key "议程")
  "oc" '(org-capture :which-key "快速捕获"))

;;; ============================================================
;;; 补全框架
;;; ============================================================

(require 'vertico)
(vertico-mode 1)
(setq vertico-cycle t)

(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overrides '((file (styles partial-completion))))

(require 'marginalia)
(marginalia-mode 1)

(require 'consult)

(require 'embark)
(require 'embark-consult)

;;; ============================================================
;;; Which-key
;;; ============================================================

(require 'which-key)
(which-key-mode)
(setq which-key-idle-delay 0.3)

;;; ============================================================
;;; Company（代码补全）
;;; ============================================================

(require 'company)
(global-company-mode 1)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 1)

;;; ============================================================
;;; LSP
;;; ============================================================

(require 'lsp-mode)
(setq lsp-keymap-prefix "C-c l"
      lsp-idle-delay 0.5
      ;; jdtls
      lsp-java-jdt-download-url nil)

;; Python (pyright)
(add-hook 'python-mode-hook #'lsp-deferred)
;; C/C++ (clangd)
(add-hook 'c-mode-hook #'lsp-deferred)
(add-hook 'c++-mode-hook #'lsp-deferred)
;; Nix (nil)
(add-hook 'nix-mode-hook #'lsp-deferred)
;; Go (gopls)
(add-hook 'go-mode-hook #'lsp-deferred)
;; TypeScript/JS
(add-hook 'typescript-mode-hook #'lsp-deferred)
(add-hook 'js-mode-hook #'lsp-deferred)
;; C# (csharp-ls)
(add-hook 'csharp-mode-hook #'lsp-deferred)

;; Rust (rustic 内置 lsp)
(require 'rustic)
(setq rustic-lsp-client 'lsp-mode
      rustic-analyzer-command '("rust-analyzer"))

;; Java (lsp-java + jdtls)
(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp-deferred)

;; Go
(require 'go-mode)

(require 'lsp-ui)
(setq lsp-ui-doc-enable t
      lsp-ui-sideline-enable t)

;;; ============================================================
;;; Projectile
;;; ============================================================

(require 'projectile)
(projectile-mode 1)
(setq projectile-completion-system 'default)

;;; ============================================================
;;; Treemacs
;;; ============================================================

(require 'treemacs)
(setq treemacs-width 30)
(require 'treemacs-projectile)
(require 'treemacs-magit)

;;; ============================================================
;;; 编辑增强
;;; ============================================================

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(require 'smartparens)
(smartparens-global-mode 1)

(require 'avy)
(general-define-key
 :states 'normal
 "gs" 'avy-goto-char-2)

;;; ============================================================
;;; Org 模式
;;; ============================================================

(require 'org)
(setq org-directory "~/org"
      org-agenda-files '("~/org")
      org-startup-folded 'content
      org-hide-emphasis-markers t
      org-pretty-entities t)

(require 'org-modern)
(global-org-modern-mode)

;;; ============================================================
;;; 语言支持
;;; ============================================================

(require 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

(require 'markdown-mode)
(require 'yaml-mode)

;;; ============================================================
;;; Helpful
;;; ============================================================

(require 'helpful)

;;; ============================================================
;;; GitHub Copilot
;;; ============================================================

(require 'copilot)
(setq copilot-indentation-alist
      '((prog-mode . 4)
        (org-mode . 2)
        (text-mode . 2)
        (python-mode . 4)
        (c-mode . 4)
        (c++-mode . 4)
        (java-mode . 4)
        (js-mode . 2)
        (typescript-mode . 2)
        (nix-mode . 2)
        (go-mode . 4)
        (rust-mode . 4)
        (csharp-mode . 4)
        (fundamental-mode . 4)))
;; 对无法推断缩进的模式静默警告，回退到 tab-width
(advice-add 'copilot--infer-indentation-offset :around
            (lambda (orig-fn)
              (let ((warning-minimum-level :error))
                (or (funcall orig-fn) tab-width))))
;; 在所有编程模式中启用
(add-hook 'prog-mode-hook 'copilot-mode)
;; Tab 接受建议（Evil insert 模式下）
(with-eval-after-load 'evil
  (define-key evil-insert-state-map (kbd "<tab>") 'copilot-accept-completion))
;; 非 Evil 下也绑定 Tab
(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "TAB")   'copilot-accept-completion)
;; 逐词接受
(define-key copilot-completion-map (kbd "C-<tab>") 'copilot-accept-completion-by-word)
;; 下一条/上一条建议
(define-key copilot-completion-map (kbd "M-n") 'copilot-next-completion)
(define-key copilot-completion-map (kbd "M-p") 'copilot-previous-completion)

;;; ============================================================
;;; GitHub Copilot Chat
;;; ============================================================

(require 'copilot-chat)
(setq copilot-chat-frontend 'markdown)
;; Leader 键绑定
(my/leader-keys
  "a"  '(:ignore t :which-key "AI")
  "aa" '(copilot-chat-ask :which-key "提问")
  "ae" '(copilot-chat-explain :which-key "解释代码")
  "ar" '(copilot-chat-review :which-key "代码审查")
  "af" '(copilot-chat-fix :which-key "修复代码")
  "ao" '(copilot-chat-optimize :which-key "优化代码")
  "at" '(copilot-chat-test :which-key "生成测试")
  "ad" '(copilot-chat-doc :which-key "生成文档")
  "ab" '(copilot-chat-open :which-key "打开对话窗口"))

;;; init.el ends here
