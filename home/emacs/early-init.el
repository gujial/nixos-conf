;;; early-init.el --- 早期初始化配置 -*- lexical-binding: t; -*-

;; 禁用包管理器（使用 Nix 管理包）
(setq package-enable-at-startup nil)

;; 提前禁用 UI 元素，加快启动速度
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; 增大 GC 阈值，加快启动速度
(setq gc-cons-threshold most-positive-fixnum)

;;; early-init.el ends here
