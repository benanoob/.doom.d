;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "beatrice"
      user-mail-address "tbd@mail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; transparency
(set-frame-parameter (selected-frame) 'alpha '98)

(add-to-list 'default-frame-alist '(height . 44))
(add-to-list 'default-frame-alist '(width . 92))

(setq-default
 delete-by-moving-to-trash t) ;; move to trash to delete


(setq
 undo-limit 80000000    ;; 80mB of undo
 auto-save-default t)

(display-time-mode 1) ;; time on modeline
(unless (string-match-p "^Power N/A" (battery))  ;; battery on laptop
  (display-battery-mode 1))

;; (menu-bar-mode)

;; (setq doom-font (font-spec :family "monospace" :size 16)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 16))

(after! avy
  (setq avy-keys '(?q ?s ?d ?f ?g ?h ?j ?k ?l ?m))
  (map! :g "C-t" #'avy-goto-char-timer)
)

;; general lsp
;; (setq company-idle-delay nil) ;; manual completion
(setq lsp-ui-sideline-enable nil   ; not anymore useful than flycheck
      lsp-ui-doc-enable nil        ; slow and redundant with K
      lsp-enable-symbol-highlighting nil
      )
;; trigger company completion
(map! :g "C-SPC" #'company-complete)
;;C module config
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"
                                "--query-driver=/usr/bin/arm-none-eabi-gcc"));;dirty quick fix for arm dev
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;; doxygen
(load "gendoxy.el") ;; doxygen plugin for C language TODO: put this in an after! statement

;; which key pops faster
(setq which-key-idle-delay 0.5)

;; keys for pane management
;;
;; paragraph for azerty
(map! :g "M-'" #'backward-paragraph)
(map! :g "M-=" #'forward-paragraph)
