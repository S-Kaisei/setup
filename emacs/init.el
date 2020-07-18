(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)

(package-initialize)

(defun copy-from-osx ()
 (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
 (let ((process-connection-type nil))
     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
       (process-send-string proc text)
       (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

(display-time)

(load-theme 'manoj-dark t)

(fset 'yes-or-no-p 'y-or-n-p)

(if window-system
    (progn
      (set-frame-parameter nil 'alpha 95)))

(add-to-list 'default-frame-alist '(font . "ricty-12"))

(require 'linum)
(global-linum-mode t)

(set-face-attribute 'linum nil
            :foreground "#ffd700"
            :background "#404040"
            :height 0.9)

(menu-bar-mode 0)

(which-function-mode 1)

(show-paren-mode 1)

(transient-mark-mode 1)

(let ((ls (member 'mode-line-buffer-identification
                  mode-line-format)))
  (setcdr ls
    (cons '(:eval (concat " ("
            (abbreviate-file-name default-directory)
            ")"))
          (cdr ls))))

(if (eq window-system 'x)
    (menu-bar-mode 1) (menu-bar-mode 0))
(menu-bar-mode nil)

(defun next-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move arg)
    (end-of-buffer)))

(global-set-key (kbd "<c-left>")  'windmove-left)
(global-set-key (kbd "<c-down>")  'windmove-down)
(global-set-key (kbd "<c-up>")    'windmove-up)
(global-set-key (kbd "<c-right>") 'windmove-right)

(defun delete-grep-header ()
  (save-excursion
    (with-current-buffer grep-last-buffer
      (goto-line 5)
      (narrow-to-region (point) (point-max)))))
(defadvice grep (after delete-grep-header activate) (delete-grep-header))
(defadvice rgrep (after delete-grep-header activate) (delete-grep-header))

(defmacro with-suppressed-message (&rest body)
  "Suppress new messages temporarily in the echo area and the `*Messages*' buffer while BODY is evaluated."
  (declare (indent 0))
  (let ((message-log-max nil))
    `(with-temp-message (or (current-message) "") ,@body)))

(setq shell-pop-shell-type '("eshell" "*eshell*" (lambda () (eshell))))
(global-set-key (kbd "C-c o") 'shell-pop)

(setq mac-command-modifier 'super)

(setq x-select-enable-clipboard t)

(setq kill-whole-line t)

(setq inhibit-startup-message t)

(setq ring-bell-function 'ignore)

(setq make-backup-files nil)

(setq auto-save-default nil)

(setq default-tab-width 4)

(setq frame-title-format "%f")

(setq inhibit-startup-message 1)

(setq initial-scratch-message "")

(setq mouse-wheel-scroll-amount '(1 ((shift) . 5)))

(setq mouse-wheel-progressive-speed nil)

(setq case-fold-search t)

(setq special-display-buffer-names '("*Help*" "*compilation*" "*interpretation*" "*grep*" ))

(setq ring-bell-function 'ignore)

(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)

(define-key global-map "\M-?" 'help-for-help)

(define-key global-map [(super i)] 'find-name-dired)

(define-key global-map [(super f)] 'rgrep)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(electric-pair-mode 1)
