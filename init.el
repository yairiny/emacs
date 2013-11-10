(require 'package)
(add-to-list 'package-archives
            '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;;show the current dir in the title bar
(setq frame-title-format '((:eval default-directory)))

;;make sure the system path is reflected properly in emacs
;; fix the PATH variable
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

 
;; Auto completion
(require 'auto-complete-config)
(ac-config-default)

;;auto complete with tab
(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

;fix for cider bug
(defun cider--library-version ()
  "Get the version in the nrepl library header."
  ;; (-when-let (version (pkg-info-library-version 'cider))
  ;;   (pkg-info-format-version version))
  "0.3.1")

;ac for cider
(require 'ac-nrepl)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))
(add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)
(eval-after-load "cider"
  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "purple1"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "orange1"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse1"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "firebrick1"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "aquamarine1"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "SlateBlue1"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "maroon1"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "red1"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "tan1")))))

;;rainbow mode
(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-mode-hook 'rainbow-delimiters-mode)

;;cider configs
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(setq cider-history-file "~/.emacs.d/nrepl-history")

(load-file "/Users/yair/code/emacs/better-defaults/better-defaults.el")
(require 'better-defaults)

;mac setup, screen size full screen
(set-face-attribute 'default nil
                    :family "Inconsolata"
                    :height 130)

;;set the default size
(if (window-system)
    (set-frame-height (selected-frame) 70))
(if (window-system)
    (set-frame-width (selected-frame) 235))

;; tabs are 2 spaces
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; make option the super key on mac
(setq mac-option-modifier 'super)

;; map meta to command key for mac
(setq ns-command-modifier 'meta)

(global-set-key [f7] 'ns-toggle-fullscreen)

(load-file "/Users/yair/code/emacs/twilight-emacs/color-theme-twilight.el")
(require 'color-theme-twilight)
(color-theme-twilight)

;;maximising on startup
(load-file "/Users/yair/code/emacs/maxframe.el/maxframe.el")
(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

;; clojure mode hooks
(add-hook 'clojure-mode-hook 
          '(lambda ()
             (local-set-key (kbd "RET") 'newline-and-indent)))

;;paredit
(require 'paredit)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-mode-hook 'paredit-mode)

;;windmove
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))

;pretty lambda
(defun esk-pretty-fn ()
  (font-lock-add-keywords nil `(("(\\(\\<fn\\>\\)"
                                 (0 (progn (compose-region (match-beginning 1)
                                                           (match-end 1)
                                                           "\u0192"
                                                           'decompose-region)))))))
(add-hook 'clojure-mode-hook 'esk-pretty-fn)
(add-hook 'cider-mode-hook 'esk-pretty-fn)

;;smex - adds ido to M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
