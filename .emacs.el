;; * ENCODING
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; * P@THS & REQUIRES
;; ** REQUIRES

;(require 'bookmark+)
(require 'ffap)
(require 'cl)
(require 'calc)
;(require 'desktop+)
(require 'saveplace)
;(require 'multi-term)
;(require 'auto-package-update)

;; (add-to-list 'load-path "/home/aziz/Documents/release_8.2.10/contrib/lisp/")
;; (require 'org-mime)


;; (add-to-list 'load-path "~/.emacs.d/uniq/")
;; (require 'mplayer-mode)
;; ;(require 'edit-server)
;; ;(require 'sunrise-commander)
;; (require 'outlined-zall-mode)

;; ;; (add-to-list 'load-path "~/.emacs.d/addons/git-modes")
;; ;; (add-to-list 'load-path "~/.emacs.d/addons/magit")
;; ;; (require 'magit)
;; ;; (setq magit-last-seen-setup-instructions "1.4.0")

;; ;(add-to-list 'load-path "~/.emacs.d/mode-line/")
;; ;(require 'mode-line-stats)
;; ;(mode-line-stats-mode)
;; ;(global-set-key "\C-ß" 'mls-mode-line-toggle)
;; ;(setq mls-modules '(cpu memory disk battery))
;; ;; (setq mls-position :right)

;; * elpa packages begins here
(package-initialize)
;; ** emacs as X window manager conf is here
;; (require 'exwm)
;; (require 'exwm-config)
;; (exwm-config-default)
;; ;; *** Application launcher
;; ;; (exwm-input-set-key (kbd "s-&")
;; ;;                     (lambda (command)
;; ;;                       (interactive (list (read-shell-command "$ ")))
;; ;;                       (start-process-shell-command command nil command)))


;; ;; ** the rest of elpa packages stuff
;; (require 'thingatpt)
;; (require 'outlined-elisp-mode)
;(require 'langtool)
;(require 'w3m)
;(require 'w3m-session)
;(require 'sr-speedbar)
;; (require 'dired-details+)
;; (require 'dired+)
;; ;(require 'calfw-gcal)
;; ;(require 'calfw)
;; (require 'fold-this)
;; (require 'hide-lines)
;; (require 'file-props)
;; (require 'helm-config)
;; (require 'emamux)
;; (file-props-dired-activate-display)
;; (file-props-dired-setup-keybindings)
(require 'w3m)
(require 'dired-x)
(load-library	"server")
(load-library	"savehist")
(load-library	"iso-transl")
(load-library	"org-clock")
(autoload	'volume "volume" "Tweak your sound card volume." t)

(fset 'yes-or-no-p 'y-or-n-p)
(icomplete-mode)
(ffap-bindings)
;(edit-server-start)


;(helm-mode		1)
(recentf-mode		1)
(delete-selection-mode	1)
(tool-bar-mode		0)
(menu-bar-mode		1)
(savehist-mode		1)
(ido-mode		1)
;(desktop-save-mode      1)
(global-auto-revert-mode t)
(if (not (server-running-p))  (server-start))
;(eshell)

;; * VARIABLES

;(add-to-list 'auto-mode-alist		'("\\.docx$"	. docx2txt))

(setq
 blink-cursor-mode			t
 calendar-date-display-form		'(dayname " " day " " monthname " " year)
 column-number-mode			t
 completion-auto-help			'lazy
 custom-file				"~/.emacs-custom.el"
 default-buffer-file-coding-system	'utf-8
 default-file-name-coding-system	'utf-8
 dired-recursive-copies			'always
 dired-recursive-deletes		'always
 display-time-format			"%a %d %b %H:%M"
 edit-server-default-major-mode		'org-mode
 enable-recursive-minibuffers		t
 gc-cons-threshold			3500000
 inferior-lisp-program			"clisp"
 langtool-language-tool-jar		"~/bin/langtool/languagetool-commandline.jar"
 langtool-mother-tongue			"fr"
 visible-bell				t
 )
;;(setq default-major-mode		'org-mode)


(setq package-enable-at-startup		t)
(setq password-cache-expiry		nil)
(setq read-file-name-completion-ignore-case t)
(setq size-indication-mode		t)
(setq time-stamp-active			t)
(setq tramp-default-method		"ssh")
(setq use-dialog-box			nil)
(setq view-read-only			t)

(setq w3m-default-save-directory	"~/.w3m")
(setq w3m-session-file			"~/.emacs.d/w3m-session")
(setq w3m-session-save-always		t)
(setq w3m-session-load-always		nil)
(setq w3m-session-show-titles		t)
(setq w3m-session-duplicate-tabs	'never)
(setq ffap-url-fetcher			'w3m-browse-url)
(setq dired-dwim-target			t)
(setq gmail-credential-file		"~/.emacs.d/credential.el")

(setq-default
	dired-omit-mode			t
	dired-omit-files			"^\\.?#\\|^\\.$\\|^\\.\\.$\\|^\\."
	frame-title-format		'(buffer-file-name "%b (%f)" "%b")
	indicate-empty-lines		t
	)

;(add-to-list 'load-path "~/.emacs.d/pdn/")
;(require 'load-directory)
(load custom-file)
;(load gmail-credential-file)
;(load "~/.gnus.el")
					;(load "~/.emacs.d/bbdb.el")
(load "~/.emacs.d/pdn/mplayer-mode.el")
(load "~/.emacs.d/pdn/pdn.el")
(load "~/.emacs.d/pdn/retrans.el")
(load "~/.emacs.d/pdn/correction.el")
(load "~/.emacs.d/pdn/publication.el")
(load "~/.emacs.d/pdn/compta.el")
(load "~/.emacs.d/pdn/misap.el")





(setq backup-by-copying       t
      backup-directory-alist  '(("." . "~/.saves"))
      delete-old-versions     t
      kept-new-versions       6
      kept-old-versions       2
      version-control         t)


(setq view-diary-entries-initially	t
      mark-diary-entries-in-calendar	t
      number-of-diary-entries		7)

(put 'dired-find-alternate-file 'disabled nil)

;; * HOOKS
(add-hook 'flyspell-mode-hook			'(lambda ()
						   (define-key flyspell-mode-map (kbd "C-z") 'transpose-chars)
						   (define-key flyspell-mode-map (kbd "C-c f") 'flyspell-buffer)
						   (define-key flyspell-mode-map "œ" 'flyspell-goto-next-error)
						   (define-key flyspell-mode-map (kbd "C-c v") 'ispell-word)
						   ))


(add-hook 'w3m-display-hook			(lambda (url) (let ((buffer-read-only nil)) (delete-trailing-whitespace))))


(add-hook 'before-save-hook			'delete-trailing-whitespace)
(add-hook 'diary-display-hook			'fancy-diary-display)
;(add-hook 'emacs-lisp-mode-hook			'outlined-elisp-find-file-hook)
;;(add-hook 'awk-mode-hook			'outlined-zall-find-file-hook)
;(add-hook 'outlined-elisp-find-file-hook	'outline-mode-map)

;(add-hook 'message-mode-hook			'bbdb-define-all-aliases 'append)

;; (add-hook 'message-mode-hook			'orgstruct++-mode 'append)
;; (add-hook 'message-mode-hook			'orgtbl-mode 'append)
;; (add-hook 'message-mode-hook			'turn-on-flyspell 'append)
;; (add-hook 'message-mode-hook			'(lambda () (local-set-key (kbd "C-c M-o") 'org-mime-htmlize)) 'append)

(add-hook 'today-visible-calendar-hook		'calendar-mark-today)
;;(add-hook 'w3m-mode-hook			'w3m-add-keys)

;; * FONCTIONS
;; ** Replace in rectangle
(require 'rect)
(defun my-search-replace-in-rectangle
  (start end search-pattern replacement search-function literal)
  "Replace all instances of SEARCH-PATTERN (as found by SEARCH-FUNCTION)
              with REPLACEMENT, in each line of the rectangle established by the START
              and END buffer positions.

              SEARCH-FUNCTION should take the same BOUND and NOERROR arguments as
              `search-forward' and `re-search-forward'.

              The LITERAL argument is passed to `replace-match' during replacement.

              If `case-replace' is nil, do not alter case of replacement text."
  (apply-on-rectangle
   (lambda (start-col end-col search-function search-pattern replacement)
     (move-to-column start-col)
     (let ((bound (min (+ (point) (- end-col start-col))
		       (line-end-position)))
	   (fixedcase (not case-replace)))
       (while (funcall search-function search-pattern bound t)
	 (replace-match replacement fixedcase literal))))
   start end search-function search-pattern replacement))

(defun my-replace-regexp-rectangle-read-args (regexp-flag)
  "Interactively read arguments for `my-replace-regexp-rectangle'
              or `my-replace-string-rectangle' (depending upon REGEXP-FLAG)."
  (let ((args (query-replace-read-args
	       (concat "Replace"
		       (if current-prefix-arg " word" "")
		       (if regexp-flag " regexp" " string"))
	       regexp-flag)))
    (list (region-beginning) (region-end)
	  (nth 0 args) (nth 1 args) (nth 2 args))))

(defun my-replace-regexp-rectangle
  (start end regexp to-string &optional delimited)
  "Perform a regexp search and replace on each line of a rectangle
              established by START and END (interactively, the marked region),
              similar to `replace-regexp'.

              Optional arg DELIMITED (prefix arg if interactive), if non-nil, means
              replace only matches surrounded by word boundaries.

              If `case-replace' is nil, do not alter case of replacement text."
  (interactive (my-replace-regexp-rectangle-read-args t))
  (when delimited
    (setq regexp (concat "\\b" regexp "\\b")))
  (my-search-replace-in-rectangle
   start end regexp to-string 're-search-forward nil))

(defun my-replace-string-rectangle
  (start end from-string to-string &optional delimited)
  "Perform a string search and replace on each line of a rectangle
              established by START and END (interactively, the marked region),
              similar to `replace-string'.

              Optional arg DELIMITED (prefix arg if interactive), if non-nil, means
              replace only matches surrounded by word boundaries.

              If `case-replace' is nil, do not alter case of replacement text."
  (interactive (my-replace-regexp-rectangle-read-args nil))
  (let ((search-function 'search-forward))
    (when delimited
      (setq search-function 're-search-forward
	    from-string (concat "\\b" (regexp-quote from-string) "\\b")))
    (my-search-replace-in-rectangle
     start end from-string to-string search-function t)))
;; ** PDN
;; *** correction
;; (defun correction()
;;   "Replace “<” to “&lt;” and some other chars in HTML.
;; This works on the current region."
;;   (interactive)
;;   ;;***********************************************;;
;;   ;;;            mise en forme                    ;;;
;;   ;;***********************************************;;
;;   (goto-char (point-min))
;;   (replace-regexp "^- \\([0-9][0-9]:\\)" "+ \\1")
;;   (goto-char (point-min))
;;   (while (search-forward "@" nil t) (replace-match "~" nil t))
;;   (goto-char (point-min))
;;   (while (search-forward "²" nil t) (replace-match "~" nil t))
;;   (goto-char (point-min))
;;   (while (search-forward "&&" nil t) (replace-match "~" nil t))
;;   (goto-char (point-min))
;;   (while (search-forward "&" nil t) (replace-match "\n" nil t))
;;   (goto-char (point-min))
;;   (while (search-forward "~" nil t) (replace-match "&" nil t))
;;   (goto-char (point-min))
;;   (while (search-forward "&" nil t) (replace-match "\n&" nil t))
;;   (goto-char (point-min))
;;   (while (search-forward " é " nil t) (replace-match "\né " nil t))
;;   (goto-char (point-min))
;;   (while (search-forward " \" " nil t) (replace-match "\n\" " nil t))
;;   (goto-char (point-min))
;;   (while (search-forward " ' " nil t) (replace-match "\n' " nil t))
;;   (goto-char (point-min))
;;   (while (search-forward " ( " nil t) (replace-match "\n( " nil t))
;;   (goto-char (point-min))
;;   (while (search-forward " - " nil t) (replace-match "\n- " nil t))
;;   (goto-char (point-min))
;;   (while (search-forward " è " nil t) (replace-match "\nè " nil t))
;;   (goto-char (point-min))
;;   (while (search-forward " _ " nil t) (replace-match "\n_ " nil t))
;;   (goto-char (point-min))
;;   (while (search-forward "=" nil t) (replace-match "\n=" nil t))
;;   (goto-char (point-min))
;;   (while (re-search-forward "  *$" nil t) (replace-match "" nil t))
;;   (goto-char (point-min))
;;   (while (re-search-forward "^  *" nil t) (replace-match "" nil t))
;;   (goto-char (point-min))
;;   (flush-lines  "^$")
;;   (goto-char (point-min))
;;   (while (search-forward "=" nil t) (replace-match "\n=" nil t))
;;   (goto-char (point-min))
;;   (while (search-forward "^+" nil t) (replace-match "\n+" nil t))
;;   (goto-char (point-min))
;;   (replace-regexp "^=\\(.*\\)$" "
;; - \\1 ?")
;;   (goto-char (point-min))
;;   (replace-regexp "^+\\(.*\\)$" "
;; - \\1 ?")
;;   (goto-char (point-min))
;;   (while (re-search-forward "^  *" nil t) (replace-match "" nil t))
;;   (goto-char (point-min))
;;   (replace-regexp ";" ".")
;;   (goto-char (point-min))
;;   (replace-regexp " *\\." ".")
;;   (goto-char (point-min))
;;   (replace-regexp "^\\([^*].*\\)\\([^?\n]\\)$" "\\1\\2.")
;;   (goto-char (point-min))
;;   (replace-regexp " *," ",")
;;   (goto-char (point-min))
;;   (replace-regexp "  *" " ")
;;   (goto-char (point-min))
;;   (replace-regexp "^- \\([0-9][0-9]:\\)" "+ \\1")
;;   (goto-char (point-min))
;;   (replace-regexp "^\\([0-9]\\)$" "\\1.")
;;   (goto-char (point-min))
;;   (replace-regexp " \\?$" " ?")
;;   (goto-char (point-min))
;;   (nommer)
;; 					;(collection)
;;   )
;; *** ferd


;; (fset 'capitales
;;       (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("<xreplace-regexp^.\\,(capitalize &)<xreplace-regexp: \\(\\w\\): \\,(capitalize \\1)<xreplace-regexp\\. \\(\\w\\)\\(\\w+\\). \\,(capitalize \\1)\\2<xreplace-regexp^\\(\\**\\) \\(\\w\\)\\(\\w+\\)\\1 \\,(capitalize \\2)\\3<xreplace-regexp- \\(\\w\\)- \\,(capitalize \\1)<" 0 "%d")) arg)))

;; (defun capitales()
;;   (interactive)
;;   (save-excursion
;;     (goto-char (point-min))
;;     (replace-regexp "^." ,(capitalize $)))

;; (substring "lo'la" (+ 1 (string-match "'" "lo'la")))
;; (substring "lo'la" 0 (string-match "'" "lo'la"))

;; (defun translate()
;;   (interactive)
;;   (setq bomba (split-string (buffer-substring-no-properties (point-min) (point-max))  )
;; 	trad '())
;;   (while bomba
;;     (setq current (pop bomba))
;;     (if ((string-match "'" current))
;; 	(progn
;; 	  (setq
;; 	   avantapos (substring current (string-match "'" current))
;; 	   current (substring current (+ 1 (string-match "'" current)))
;; 	   )

;; 	  )

;;       )
;;     (find-file "/home/azyvers/dict-france/Atelier/nude.txt")
;;     (goto-char (point-min))
;;     (if (not (re-search-forward (concat "^" current "|") nil t))
;; 	(setq trad "NOVAL")
;;       (progn
;; 	(goto-char (point-min))
;; 	(goto-char (re-search-forward (concat "^" current "|") nil t))
;; 	(setq begin (point))
;; 	(end-of-line)
;; 	(backward-char)
;; 	(setq end (point))
;; 	(setq trad (buffer-substring-no-properties begin end))))
;;     (with-current-buffer "*scratch*"
;;       (insert (concat trad " ")))
;; ;      (insert (concat "\"" trad "\": \"" current "\",\n")))
;;     )
;;   )

;; *** todoc
;; (defun todoc()
;;   (interactive)
;;   (setq
;;    todoc-script "~/bin/todoc"
;;    this-buffer (buffer-name)
;;    this-file (buffer-file-name)
;;    doc-file (concat (file-name-sans-extension this-file) ".doc")
;;    destination (concat "~/org/livraison/" (format-time-string "%m-%Y"))
;;    )
;;   ;; (set-process-filter (get-process "todoc") (lambda (process output)
;;   ;; 						(string-match "Process todoc finished" output)))
;;   (progn
;;     (switch-to-buffer-other-window "*todoc*")
;;     (goto-char (point-max))
;;     (switch-to-buffer-other-window this-buffer))
;;   (start-process "todoc" "*todoc*" todoc-script this-file)
;;   (sleep-for 2)
;;   (if (file-exists-p destination)
;;       (rename-file doc-file destination 1)
;;     (progn
;;       (make-directory destination)
;;       (rename-file doc-file destination 1)))
;;   )
;; ;; *** mafia
;; (defun mafia()
;;   (interactive)
;;   (setq
;;    mafia-script "~/bin/mafia"
;;    this-file (buffer-file-name)
;;    this-buffer (buffer-name)
;;    )
;;   (progn
;;     (switch-to-buffer-other-window "*mafia*")
;;     (goto-char (point-max))
;;     (switch-to-buffer-other-window this-buffer))
;;   (start-process "mafia" "*mafia*" mafia-script this-file)
;;   )
;; ;; ** FACTURATION
;; ;; *** org-time-string-to-seconds
;; (defmacro with-time (time-output-p &rest exprs)
;;   "Evaluate an org-table formula, converting all fields that look
;; like time data to integer seconds.  If TIME-OUTPUT-P then return
;; the result as a time value."
;;   (list
;;    (if time-output-p 'org-time-seconds-to-string 'identity)
;;    (cons 'progn
;; 	 (mapcar
;; 	  (lambda (expr)
;; 	    `,(cons (car expr)
;; 		    (mapcar
;; 		     (lambda (el)
;; 		       (if (listp el)
;; 			   (list 'with-time nil el)
;; 			 (org-time-string-to-seconds el)))
;; 		     (cdr expr))))
;; 	  `,@exprs))))


;; ;; ** STENO
;; ;; *** translate
;; (defun translate()
;;   (interactive)
;;   (downcase-region (point-min) (point-max))
;;   (goto-char (point-min))
;;   (setq moreline t)
;;   (setq nline 0)
;;   (while moreline								;; pour chaque ligne
;;     (setq p1 (line-beginning-position))
;;     (setq p2 (line-end-position))
;;     (setq maliste (split-string (buffer-substring-no-properties p1 p2)))
;;     (setq nline (+ 1 nline))
;;     (message (concat "line n°: "  (number-to-string nline)))
;;     (setq moreline (= 0 (forward-line 1)))
;;     (with-temp-buffer								;; pour chaque mot
;;       (setq compteur 1
;; 	    orth ""
;; 	    steno "")
;;       (while maliste
;; 	(setq mot (pop maliste))

;; 	(if (numberp (string-match "'" mot))
;; 	    (progn
;; 	      (setq avantapos (substring mot 0 (string-match "'" mot))
;; 		    mot (substring mot (+ 1 (string-match "'" mot)))
;; 		    apos "'")
;; 	      (if (string= "l" avantapos) (setq stelision "L"))
;; 	      (if (string= "t" avantapos) (setq stelision "T"))
;; 	      (if (string= "j" avantapos) (setq stelision "Y"))
;; 	      (if (string= "m" avantapos) (setq stelision "M"))
;; 	      (if (string= "s" avantapos) (setq stelision "S"))
;; 	      (if (string= "c" avantapos) (setq stelision "S"))
;; 	      (if (string= "n" avantapos) (setq stelision "N"))
;; 	      (if (string= "d" avantapos) (setq stelision "T*"))
;; 	      (if (string= "qu" avantapos) (setq stelision "K")))
;; 	  (progn
;; 	    (setq  apos ""
;; 		   avantapos ""
;; 		   stelision "")))

;; 	  (with-temp-buffer
;; 	    (find-file "/home/azyvers/dict-france/Atelier/nude.txt")
;; 	    (goto-char (point-min))
;; 	    (if (numberp (re-search-forward (concat "^" mot "|") nil t))
;; 	      (progn
;; 		(goto-char (point-min))
;; 		(goto-char (re-search-forward (concat "^" mot "|") nil t))
;; 		(setq begin (point))
;; 		(setq end (line-end-position))
;; 		(setq trad (buffer-substring-no-properties begin end)))
;; 	      (setq trad "---")))
;; 	  (setq
;; 	   orth (concat orth " " avantapos apos mot)
;; 	   steno (concat steno "/" stelision trad)
;; 	   compteur (+ 1 compteur))
;; 	  )
;; 	)

;;     (with-current-buffer "*scratch*"
;;       (insert  (concat "\"" steno "\": \"" orth "\",\n"))
;;       )
;;     )
;;     (with-current-buffer "*scratch*"
;;       (goto-char (point-min))
;;       (replace-string "\"/" "\"")
;;       (goto-char (point-min))
;;       (replace-string "\" " "\""))
;;   )



;; ** MY-DESKTOP LIBRARY
;; my-desktop-save -- Save the current session by name
;; my-desktop-save-and-clear -- Same as above, but clear out all the buffers so you start with a "clean" session
;; my-desktop-read -- Load a session by name
;; my-desktop-change -- Save the current session and load a different one
;; my-desktop-name -- Echo the current session name

;; (require 'desktop)

;; (defvar my-desktop-session-dir
;;   (concat (getenv "HOME") "/.emacs.d/desktop-sessions/")
;;   "*Directory to save desktop sessions in")

;; (defvar my-desktop-session-name-hist nil
;;   "Desktop session name history")

;; (defun my-desktop-save (&optional name)
;;   "Save desktop by name."
;;   (interactive)
;;   (unless name
;;     (setq name (my-desktop-get-session-name "Save session" t)))
;;   (when name
;;     (make-directory (concat my-desktop-session-dir name) t)
;;     (desktop-save (concat my-desktop-session-dir name) t)))

;; (defun my-desktop-save-and-clear ()
;;   "Save and clear desktop."
;;   (interactive)
;;   (call-interactively 'my-desktop-save)
;;   (desktop-clear)
;;   (setq desktop-dirname nil))

;; (defun my-desktop-read (&optional name)
;;   "Read desktop by name."
;;   (interactive)
;;   (unless name
;;     (setq name (my-desktop-get-session-name "Load session")))
;;   (when name
;;     (desktop-clear)
;;     (desktop-read (concat my-desktop-session-dir name))))

;; (defun my-desktop-change (&optional name)
;;   "Change desktops by name."
;;   (interactive)
;;   (let ((name (my-desktop-get-current-name)))
;;     (when name
;;       (my-desktop-save name))
;;     (call-interactively 'my-desktop-read)))

;; (defun my-desktop-name ()
;;   "Return the current desktop name."
;;   (interactive)
;;   (let ((name (my-desktop-get-current-name)))
;;     (if name
;;         (message (concat "Desktop name: " name))
;;       (message "No named desktop loaded"))))

;; (defun my-desktop-get-current-name ()
;;   "Get the current desktop name."
;;   (when desktop-dirname
;;     (let ((dirname (substring desktop-dirname 0 -1)))
;;       (when (string= (file-name-directory dirname) my-desktop-session-dir)
;;         (file-name-nondirectory dirname)))))

;; (defun my-desktop-get-session-name (prompt &optional use-default)
;;   "Get a session name."
;;   (let* ((default (and use-default (my-desktop-get-current-name)))
;;          (full-prompt (concat prompt (if default
;;                                          (concat " (default " default "): ")
;;                                        ": "))))
;;     (completing-read full-prompt (and (file-exists-p my-desktop-session-dir)
;;                                       (directory-files my-desktop-session-dir))
;;                      nil nil nil my-desktop-session-name-hist default)))

;; (defun my-desktop-kill-emacs-hook ()
;;   "Save desktop before killing emacs."
;;   (when (file-exists-p (concat my-desktop-session-dir "last-session"))
;;     (setq desktop-file-modtime
;;           (nth 5 (file-attributes (desktop-full-file-name (concat my-desktop-session-dir "last-session"))))))
;;   (my-desktop-save "last-session"))

;; (add-hook 'kill-emacs-hook 'my-desktop-kill-emacs-hook)
;; (my-desktop-read "last-session")








;; ** CHECK-JSON
;; (defun find-broken-json ()
;;   "Rudimentary function to check Plover dictionary entries for ones that are malformed. Move point to the beginning of the line of the first entry, then do M-x find-broken-json <RET>. It will (hopefully) fail if it hits a line that contains an invalid entry (though point may be on the following line depending on what is wrong with the entry, so you should check both the current and previous lines when it stops. Once you've fixed an error you can either move point to the beginning of the formerly-broken entry and re-run from there, or just start over at the beginning, but I recommend at least moving back to before the hopefully-fixed-entry in the file to double-check that it is now fixed. At most there needs to be only whitespace between point and the opening quotation mark for the stenographic stroke of an entry when you invoke find-broken-json for find-broken-json to work properly. It assumes that both the steno stroke and the replacement text are in quotation marks and should fail if they are not. The Plover dictionary can be quite large; do not be surprised if this function takes a few minutes to complete checking the entire thing. It should fail on the last entry because that entry does not have a comma after it; users are strongly encouraged to check the final entry by visual inspection and to make sure that there is a closing brace after it. Be advised that, given its rudimentary nature, it may stop on valid entries and it may miss invalid entries; no warranties are provided, and I make no guarantees about the fitness of this function for use on any computer. Do not taunt find-broken-json. Best of luck! ^_^"
;;   (interactive)
;;   (while (and (not (eq (point) (point-max))))
;;     (let* ((beginning (point))
;; 	   (end (search-forward-regexp "\"\\s *," nil t))
;; 	   (dict-entry (if end (buffer-substring beginning end) nil)))
;;       (with-temp-buffer
;; 	(insert dict-entry)
;; 	(goto-char (point-min))
;; 	(search-forward-regexp "\\`\\s *\"[^\"]*\"\\s *:\\s *\"[^\"]*\\(\\\\\"\\)?[^\"]*\"\\s *,\\'")))))
;; ;; ** Blogger ~/.emacs.d/elpa/bpe-20131227.2120/bpe.el
;; ;(require 'bpe)
;; (require 'htmlize nil 'noerror)
;; (setq bpe:blog-name "Sténotypie Underground")
;; ;(define-key org-mode-map (kbd "C-c C-p") 'bpe:post-article)
;; ;(define-key org-mode-map (kbd "C-c C-i") 'bpe:insert-template)

;; ;; ** AUTRES
;; *** kill buffer and delete file
(defun killanddelete()
  (interactive)
  (setq filename (buffer-file-name))
  (kill-buffer nil)
  (delete-file filename t))
(global-set-key (kbd "C-c K") 'killanddelete)
;; *** aziz scroll-up
(fset 'aziz-scroll-up
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("-10" 0 "%d")) arg)))
;; *** dos2unix
;; C-x C-m f
(defun dos2unix ()
  "Not exactly but it's easier to remember"
  (interactive)
  (set-buffer-file-coding-system 'unix 't) )

;; *** dmj:turn-headline-into-org-mode-link
(defun dmj:turn-headline-into-org-mode-link ()
  "Replace word at point by an Org mode link."
  (interactive)
  (when (org-at-heading-p)
    (let ((hl-text (nth 4 (org-heading-components))))
      (unless (or (null hl-text)
                  (org-string-match-p "^[ \t]*:[^:]+:$" hl-text))
        (beginning-of-line)
        (search-forward hl-text (point-at-eol))
        (replace-string
         hl-text
         (format "[[file:%s.org][%s]]"
                 (org-link-escape hl-text)
                 (org-link-escape hl-text '((?\] . "%5D") (?\[ . "%5B"))))
         nil (- (point) (length hl-text)) (point))))))

;; *** my-align-all-tables
(defun my-align-all-tables ()
  (interactive)
  (org-table-map-tables 'org-table-align 'quietly))

;; *** org-to-org-handle-includes
(defun org-to-org-handle-includes ()
  "Copy the contents of the current buffer to OUTFILE,
recursively processing #+INCLUDEs."
  (let* ((s (buffer-string))
         (fname (buffer-file-name))
         (ofname (format "%s.I.org" (file-name-sans-extension fname))))
    (setq result
          (with-temp-buffer
            (insert s)
            (org-export-handle-include-files-recurse)
            (buffer-string)))
    (find-file ofname)
    (delete-region (point-min) (point-max))
    (insert result)
    (save-buffer)))


;; *** rename-current-file-or-buffer
(defun rename-current-file-or-buffer ()
  (interactive)
  (if (not (buffer-file-name))
      (call-interactively 'rename-buffer)
    (let ((file (buffer-file-name)))
      (with-temp-buffer
	(set-buffer (dired-noselect file))
	(dired-do-rename)
	(kill-buffer nil))))
  nil)
(global-set-key "\C-cR" 'rename-current-file-or-buffer)



;; *** prepare-html
;; (defun prepare-html ()
;;   (interactive)
;;   (time-guide)
;;   (goto-char (point-max))
;;   (insert "\n")
;;   (insert-file-contents "~/.emacs.d/org-templates/jwplayer.template")
;;   (goto-char (point-min))
;;   (insert "#+SETUPFILE: ~/.emacs.d/org-templates/level-0.org\n")
;;   (re-search-forward "\\* \\(.*\\)$" nil t)
;;   (beginning-of-line)
;;   (insert (concat "#+Title: " (match-string 1)))
;;   (kill-line)
;;   (goto-char (point-max))
;;   (re-search-backward "æææ" nil t)
;;   )

(fset 'time-guide
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("xreplace-regexp^- \\([0-9]\\{0,2\\}:\\{0,1\\}[0-9]\\{0,2\\}:\\{0,1\\}[0-9]\\{1,2\\}\\) :: \\(.*\\)$*** \\2
#+HTML:<a href=\"javascript:void(0)\" onclick=\"jwplayer().seek(\\,(org-time-string-to-seconds \\1));jwplayer().play();\">\\1</a><" 0 "%d")) arg)))

(defun prepare()
  (interactive)
  (setq pattern "^- \\([0-9]\\{0,2\\}:\\{0,1\\}[0-9]\\{0,2\\}:\\{0,1\\}[0-9]\\{1,2\\}\\) :: \\(.*\\)$")
  (while (re-search-forward "^- \\([0-9]\\{0,2\\}:\\{0,1\\}[0-9]\\{0,2\\}:\\{0,1\\}[0-9]\\{1,2\\}\\) :: \\(.*\\)$" nil t)
    (setq
     temps (substring-no-properties (match-string 1))
     question (substring-no-properties (match-string 2))
     jwplayerS (number-to-string (org-time-string-to-seconds temps))
     rempla (concat "\#+HTML:<table><tr><td><button class=\"btn btn-mini\" onclick=\"jwplayer().seek(" jwplayerS ");\">" temps "</button></td><td style=\"padding:5px;\"><b>" question "</b></td></tr></table>")
     )
    (kill-region (point) (line-beginning-position))
    (insert rempla)
    )

  )


;; *** logik
(defun logik ()
  (interactive)
  (save-excursion
    (re-search-backward "&" nil nil)
    (replace-match (char-to-string (read-char-exclusive "what character" t)))))
(global-set-key (kbd "C-c DEL") 'logik)

;; *** aziz-mail moved to credential.el



;; *** find-file-as-root
(defun find-file-as-root ()
  "Open the current open file via tramp and the /su:: or /sudo:: protocol"
  (interactive)
  (let ((running-ubuntu
	 (and (executable-find "lsb_release")
	      (string= (car (split-string (shell-command-to-string "lsb_release -ds"))) "Ubuntu"))))
    (find-file (concat (if running-ubuntu "/sudo::" "/su::") (buffer-file-name)))))

;; *** figlet-region (&optional b
(defun figlet-region (&optional b e)
  (interactive "r")
  (shell-command-on-region b e "figlet" (current-buffer) t)
  (comment-region (mark) (point)))

;; *** w3m-open-this-buffer
(defun w3m-open-this-buffer ()
  "Show this buffer in w3m"
  (interactive)
  (w3m-find-file (buffer-file-name)))

;; *** google-search
(defun google-search ()
  "Do a Google search of the symbol at the point"
  (interactive)
  (with-current-buffer (buffer-name)
    (switch-to-buffer-other-window
     (w3m-browse-url (concat "http://www.google.fr/search?q="
			     (if (region-active-p)
	    (buffer-substring-no-properties (region-beginning) (region-end))
	  (word-at-point)
	  )
;; (thing-at-point 'symbol)
)))
    (xsteve-flip-windows)
    (deactivate-mark)))

;; *** synonymes-search
(defun synonymes-search ()
  "Do a synonymes search of the symbol at the point"
  (interactive)
  (with-current-buffer (buffer-name)
    (switch-to-buffer-other-window
     (w3m-browse-url (concat "http://www.linternaute.com/dictionnaire/fr/definition/"
			     (thing-at-point 'symbol) "/")))
    (xsteve-flip-windows)))

;; *** xsteve-flip-windows
;; (defun xsteve-flip-windows ()
;;   (interactive)
;;   (let ((cur-buffer (current-buffer))
;; 	(top-buffer)
;; 	(bottom-buffer))
;;     (pop-to-buffer (window-buffer (frame-first-window)))
;;     (setq top-buffer (current-buffer))
;;     (other-window 1)
;;     (setq bottom-buffer (current-buffer))
;;     (switch-to-buffer top-buffer)
;;     (other-window -1)
;;     (switch-to-buffer bottom-buffer)
;;     (pop-to-buffer cur-buffer)))

;; ;; *** facture
;; (defun facture()
;;   (interactive)
;;   (find-file "~/facturage/0_facture.org")
;;   (goto-char (point-min))
;;   (outline-next-visible-heading 1)
;;   (org-narrow-to-subtree))

;; ;; *** facgen
;; (defun facgen()
;;   (interactive)
;;   (org-table-iterate)
;;   (goto-char (point-min))
;;   (replace-regexp "\\<0\.00\\>" " ")
;;   (org-cycle)
;;   (save-buffer)
;;   (widen)
;;   (setq org-confirm-babel-evaluate nil)
;;   (org-export-as-utf8)
;;   (with-current-buffer "0_facture.txt"
;;     (goto-char (point-min))
;;     (search-forward "<" nil t)
;;     (setq splitPos (1- (point)))
;;     (kill-region (point-min) splitPos)
;;     (replace-regexp "\\\"\\\[" "\"")
;;     (replace-regexp "\\\]\\\"" "\"")
;;     (flush-lines "\*" (point-min) (point-max))
;;     (flush-lines "^$" (point-min) (point-max))
;;     (save-buffer)
;;     (call-process "pdftk" nil "*scratch*" nil
;; 		  "ABC Portage_Bon de commande_TYPE FR.pdf"
;; 		  "fill_form" "0_facture.txt" "output" "test.pdf")
;;     (call-process "pdftk" nil "*scratch*" nil
;; 		  "test.pdf" "burst" "output" "page_%d.pdf")
;;     (call-process "convert" nil "*scratch*" nil
;; 		  "-density" "100" "page_1.pdf" "page_1.png")
;;     (call-process "convert" nil "*scratch*" nil
;; 		  "-density" "100" "page_2.pdf" "page_2.png")
;;     (call-process "composite" nil "*scratch*" nil
;; 		  "-geometry"  "228x101+560+950" "signature.png"  "page_1.png"  "page_1b.png")
;;     (call-process "composite" nil "*scratch*" nil
;; 		  "-geometry"  "228x101+560+920" "signature.png"  "page_2.png"  "page_2b.png")
;;     (call-process "convert" nil "*scratch*" nil
;; 		  "-density" "100" "page_1b.png" "page_1.pdf")
;;     (call-process "convert" nil "*scratch*" nil
;; 		  "-density" "100" "page_2b.png" "page_2.pdf")
;;     (call-process "pdftk" nil "*scratch*" nil
;; 		  "page_1.pdf" "page_2.pdf" "cat" "output" "test_signed.pdf")
;;     ;; (call-process "xpdf" nil "*scratch*" nil "test_signed.pdf")
;;     ;; (start-process "my-process" "*scratch*"
;;     ;;                "pdftk" "ABC Portage_Bon de commande_TYPE FR.pdf"
;;     ;;                "fill_form" "facture.txt" "output" "test.pdf")
;;     (start-process "my-process2" "*scratch*"
;; 		   "acroread" "test_signed.pdf")
;;     (start-process "my-process3" "*scratch*"
;; 		   "rm"
;; 		   "doc_data.txt"
;; 		   "page_1b.png"
;; 		   "page_1.pdf"
;; 		   "page_1.png"
;; 		   "page_2b.png"
;; 		   "page_2.pdf"
;; 		   "page_2.png"
;; 		   )

;;     ))

;; ;; *** docx2txt
;; (defun docx2txt ()
;;   "Run docx2txt on the entire buffer."
;;   (setq
;;    a (buffer-name)
;;    b (file-name-sans-extension a)
;;    c (concat b ".org")
;;    )
;;   (shell-command-on-region (point-min) (point-max) "docx2txt" c)
;;   (kill-buffer a)
;;   (switch-to-buffer c)
;;   )
;; (put 'narrow-to-region 'disabled nil)


;; *** flyspell-goto-previous-error
(defun flyspell-goto-previous-error ()
  "Go to the next previously detected error.
In general FLYSPELL-GOTO-NEXT-ERROR must be used after
FLYSPELL-BUFFER."
  (interactive)
  (let ((pos (point))
	(min (point-min)))
    (if (and (eq (current-buffer) flyspell-old-buffer-error)
	     (eq pos flyspell-old-pos-error))
	(progn
	  (if (= flyspell-old-pos-error min)
	      ;; goto beginning of buffer
	      (progn
		(message "Restarting from beginning of buffer")
		(goto-char (point-max)))
	    (backward-word 1))
	  (setq pos (point))))
    ;; seek the next error
    (while (and (> pos min)
		(let ((ovs (overlays-at pos))
		      (r '()))
		  (while (and (not r) (consp ovs))
		    (if (flyspell-overlay-p (car ovs))
			(setq r t)
		      (setq ovs (cdr ovs))))
		  (not r)))
      (setq pos (1- pos)))
    ;; save the current location for next invocation
    (setq flyspell-old-pos-error pos)
    (setq flyspell-old-buffer-error (current-buffer))
    (goto-char pos)
    (if (= pos min)
	(message "No more miss-spelled word!"))))


;; *** zaya
(defun zaya()
  "Replace word at point."
  (interactive)
  (setq from
	(if (region-active-p)
	    (buffer-substring-no-properties (region-beginning) (region-end))
	  (word-at-point)))
  (setq to (read-from-minibuffer "Remplacer par : " from))
  (save-excursion
    (goto-char (point-min))
    (query-replace-regexp from to t)))

;; *** chomp
(defun chomp(str)
  (while (string-match " " str)
    (setq str (replace-match "_" t t str)))
  str)

;; *** lomp
(defun lomp(str)
  (while (string-match "/" str)
    (setq str (replace-match "_" t t str)))
  str)

;; *** chomplomp
(defun chomplomp(str)
  (while (string-match "[ /]" str)
    (setq str (replace-match "_" t t str)))
  str)


;; *** is-short
(defun is-short(str)
  (if (string-match   "^\\([0-9][0-9]:[0-9][0-9]\\)$" str) t nil))

;; *** hmgn
(defun hmgn(str)
  (concat "0:" str))
;; *** clients-tag-lookup
(defun clients-tag-lookup()
  (interactive)
  (setq tag (thing-at-point 'word))
  (find-file-other-window "~/org/clients.org")
  (widen)
  (goto-char (point-min))
  (goto-char  (search-forward tag))
  (org-narrow-to-subtree)
  (org-columns)
  )

;; *** copy-location-to-clip
(defun copy-location-to-clip()
  (interactive)
  (kill-new (buffer-file-name)))

;; *** org-summary-todo (n-done
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

;; *** yank-to-x-clipboard
(defun yank-to-x-clipboard ()
  (interactive)
  (if (region-active-p)
      (progn
	(shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
	(message "Yanked region to clipboard!")
	(deactivate-mark))
    (message "No region active; can't yank to clipboard!")))


;; *** vlctv
;; (defun vlctv(a)
;;   (if (get-process "RADIO")
;;       (progn (kill-process "RADIO")
;; 	     (sleep-for 2)
;; 	     (start-process  "RADIO" "*RADIO*" "vlc" a))
;;     (start-process  "RADIO" "*RADIO*" "vlc"  a)))

;; ;; *** liretv
;; (defun liretv(a)
;;   (if (get-process "TV")
;;       (progn (kill-process "TV")
;; 	     (sleep-for 2)
;; 	     (start-process  "TV" "*TV*" "mplayer" "-quiet" "-nocache" a))
;;     (start-process  "TV" "*TV*" "mplayer" "-quiet" "-nocache" a)))

;; ;; *** lirelelien
;; (defun lirelelien(a)
;;   (if (get-process "RADIO")
;;       (progn (kill-process "RADIO")
;; 	     (sleep-for 2)
;; 	     (start-process  "RADIO" "*RADIO*" "mplayer" "-quiet" a))
;;     (start-process  "RADIO" "*RADIO*" "mplayer" "-quiet" a)))

;; ;; *** enrgislelien
;; (defun enrgislelien(a)
;;   (if (get-process "RADIO")
;;       (progn (kill-process "RADIO")
;; 	     (sleep-for 2)
;; 	     (start-process  "RADIO" "*RADIO*" "mplayer" "-quiet" "-dumpstream" "-dumpfile"  "fichier.wmv" a))
;;     (start-process  "RADIO" "*RADIO*" "mplayer" "-quiet" "-dumpstream" "-dumpfile" "fichier.wmv" a)))

;; ;; *** radio
;; (defun radio()
;;   (interactive)
;;   (find-file "~/org/radios.org"))

;; * TABBAR
(tabbar-mode)
(setq tabbar-tab-label-function (lambda (tab) (format " %s " (car tab))))

;; Tabbar settings
(set-face-attribute
 'tabbar-default nil
 ;; :background "gray60")
 :background "#202020"
 :box '(:line-width 1 :color "black" :style nil))
(set-face-attribute
 'tabbar-unselected nil
 ;; :background "gray85"
 :background "gray30"
 :foreground "white"
 :box '(:line-width 5 :color "gray30" :style nil))
(set-face-attribute
 'tabbar-selected nil
 ;; :background "#f2f2f6"
 :background "gray75"
 :foreground "black"
 :box '(:line-width 5 :color "gray75" :style nil))
(set-face-attribute
 'tabbar-highlight nil
 ;; :background "#f2f2f6"
 :background "white"
 :foreground "black"
 :underline nil
 :box '(:line-width 5 :color "white" :style nil))
;;(set-face-attribute
;;'tabbar-button nil
;; :box '(:line-width 1 :color "gray72" :style released-button))
;;:box '(:line-width 0 :color "gray72" :style nil))
(set-face-attribute
 'tabbar-separator nil
 :height 1.0)

(global-set-key (kbd "C-c <left>")	'tabbar-backward)
(global-set-key (kbd "C-c <right>")	'tabbar-forward)
(global-set-key	"\M-n"			'tabbar-forward)
(global-set-key	"\M-p"			'tabbar-backward)
;;(define-key dired-mode-map	(kbd "M-p")		'tabbar-backward)

(setq tabbar-buffer-groups-function
      (lambda ()
	(list "All Buffers")))

(setq tabbar-buffer-list-function
      (lambda ()
	(remove-if
	 (lambda(buffer)
	   (find (aref (buffer-name buffer) 0) " *"))
	 (buffer-list))))
;; * KEYS
(global-set-key			(kbd "<C-S-up>")	'buf-move-up)
(global-set-key			(kbd "<C-S-down>")	'buf-move-down)
(global-set-key			(kbd "<C-S-left>")	'buf-move-left)
(global-set-key			(kbd "<C-S-right>")	'buf-move-right)
(global-set-key			(kbd "C-c <up>")	'maximize-window)
(global-set-key			(kbd "C-c <down>")	'minimize-window)
(global-set-key			(kbd "C-c <right>")	'balance-windows)
(global-set-key			(kbd "C-x C-b")		'ibuffer)
(global-set-key			(kbd "C-c d")		'backup-this-file)
(global-set-key			(kbd "C-c h")		'helm-mini)
(global-set-key			(kbd "C-h t")		'clients-tag-lookup)
;;(global-set-key			(kbd "C-x C-f")		'helm-find-files)
(global-set-key			(kbd "C-x C-f")		'find-file)
;;(global-set-key			(kbd "C-x f")		'find-file-as-root)
;;(global-set-key			(kbd "C-x C-f")		'set-fill-column)
;;(global-set-key			(kbd "C-x t")		'multi-term)
(global-set-key			(kbd "C-x l")		'copy-location-to-clip)
(global-set-key			(kbd "M-a")		'dabbrev-expand)
(global-set-key			(kbd "C-x r M-%")	'my-replace-string-rectangle)
(global-set-key			(kbd "C-x r C-M-%")	'my-replace-regexp-rectangle)

(global-set-key			[f7]			'recentf-open-files)
(global-set-key			[f8]			'toggle-viper-mode)
(global-set-key			"\M-[1;5C"		'forward-word)   ;  Ctrl+right->forward word
(global-set-key			"\M-[1;5D"		'backward-word)  ;  Ctrl+left-> backward word
(global-set-key			"\C-cu"			'browse-url)
(global-set-key			"\C-cg"			'browse-url-at-point)
(global-set-key			"\C-cl"			'goto-line)
(global-set-key			"\C-xœ"			'delete-window)
(global-set-key			"\C-x&"			'delete-other-windows)
(global-set-key			"\C-xé"			'split-window-below)
(global-set-key			"\C-x\""		'split-window-right)

;;(define-key global-map		"\C-b"			'aziz-scroll-up)
(define-key global-map		"\C-z"			'undo)
(define-key global-map		"\C-v"			'scroll-other-window)
(define-key global-map		"\C-o"			'other-window)
(define-key global-map		"\C-cx"			'xsteve-flip-windows)
(define-key global-map		"\C-cw"			'google-search)
(define-key global-map		"\C-cs"			'synonymes-search)
;(define-key global-map		"\C-xp"			'sr-speedbar-toggle)
(define-key global-map		"\C-cm"			'gnus-no-server)
(define-key global-map		"\C-cr"			'zaya)
(define-key global-map		"\C-ck"			'helm-show-kill-ring)
(define-key global-map		"\C-cb"			'display-buffer)
(define-key global-map		"\C-cn"			'find-file-other-window)

;; (define-key dired-mode-map	(kbd "C-p")		'dired-omit-mode)
;; (define-key dired-mode-map	(kbd "C-o")		'other-window)
;; (define-key dired-mode-map	(kbd "<return>")	'dired-find-alternate-file) ; was dired-advertised-find-file
;; (define-key dired-mode-map	(kbd "^")		(lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory


;(require 'viewer)
;; (define-key view-mode-map	"j"		'next-line)
;; (define-key view-mode-map	"k"		'previous-line)
;; (define-key view-mode-map	"l"		'right-char)
;; (define-key view-mode-map	"h"		'left-char)
;; (define-key view-mode-map	"e"		'View-exit-and-edit)

;; (define-key help-mode-map	"j"		'next-line)
;; (define-key help-mode-map	"k"		'previous-line)
;; (define-key help-mode-map	"l"		'right-char)
;; (define-key help-mode-map	"h"		'left-char)

;; (define-key w3m-mode-map	"\C-dt"		'google-translate-at-point)
;; (define-key w3m-mode-map	"\C-ddt"	'google-translate-at-point-reverse)
;; (define-key w3m-mode-map	"\M-p"		'w3m-previous-buffer)
;; (define-key w3m-mode-map	"\M-n"		'w3m-next-buffer)
;; (define-key w3m-mode-map	"k"		'previous-line)
;; (define-key w3m-mode-map	"j"		'next-line)

(add-hook 'term-mode-hook
              '(lambda ()
                 (term-set-escape-char ?\C-x)))

(defalias	'rr	'replace-regexp)
(defalias	'qrr	'query-replace-regexp)
(defalias	'sp	'show-paren-mode)
(defalias	'lp	'list-packages)
(defalias	'sr	'shell-command-on-region)

;; (global-set-key "\C-xla" 'langtool-check-buffer)
;; (global-set-key "\C-xld" 'langtool-check-done)
;; (global-set-key "\C-cll" 'langtool-switch-default-language)
;; (global-set-key "\C-xlc" 'langtool-show-message-at-point)
;; (global-set-key "\C-xlx" 'langtool-correct-buffer)
;; ** W3M-SESSIONS-KEYS
;(defun w3m-add-keys ()
;;   (define-key w3m-mode-map "S" 'w3m-session-save)
;;   (define-key w3m-mode-map "L" 'w3m-session-load))
;; * BBDB
;(require 'bbdb-autoloads)
;; (require 'bbdb)
;; (bbdb-initialize 'gnus 'message)
;; (bbdb-insinuate-message)		;
;; (bbdb-mua-auto-update-init)

;; (add-hook 'gnus-startup-hook	'bbdb-insinuate-gnus)
;; (add-hook 'mail-setup-hook	'bbdb-insinuate-sendmail)
;; (add-hook 'message-setup-hook	'bbdb-get-mail-aliases)

;; (setq bbdb-ignore-some-messages-alist		(quote (
;; 							("From" . "no.?reply\\|DAEMON\\|darty\\|daemon\\|reply\\|canon\\|pap.fr\\|yousendit\\|newsletter")
;; 							("To" . "ploversteno")))
;;       bbdb/news-auto-create-p			(quote bbdb-ignore-some-messages-hook)
;;       bbdb/mail-auto-create-p			(quote bbdb-ignore-some-messages-hook)
;;       bbdb-north-american-phone-numbers		nil
;;       bbdb-dwim-net-address-allow-redundancy	t   ;; always use full name
;;       bbdb-quiet-about-name-mismatches		2   ;; show name-mismatches 2 secs
;;       bbdb-completion-type			nil ;; complete on anything
;;       bbdb-complete-name-allow-cycling		t   ;; cycle through matches this only works partially
;;       bbdb-use-alternate-names			t   ;; use AKA
;;       bbdb-always-add-address			t
;;       )
;; * MAIL-REGION
;; (defun mail-region (b e to subject)
;;   "Send the current region in an email"
;;   (interactive "r\nsRecipient: \nsSubject: ")
;;   (let ((orig-buffer (current-buffer)))
;;     (message-mail to subject)
;;     (message-goto-body)
;;     (insert (save-excursion (set-buffer orig-buffer)
;; 			    (buffer-substring-no-properties b e)))
;;     (message-send-and-exit)))

;; ;; * asciify

;; (defun asciify-text (ξstring &optional ξfrom ξto)
;; "Change some Unicode characters into equivalent ASCII ones.
;; For example, “passé” becomes “passe”.

;; This function works on chars in European languages, and does not transcode arbitrary Unicode chars (such as Greek, math symbols).  Un-transformed unicode char remains in the string.

;; When called interactively, work on text selection or current block.

;; When called in lisp code, if ξfrom is nil, returns a changed string, else, change text in the region between positions ξfrom ξto."
;;   (interactive
;;    (if (use-region-p)
;;        (list nil (region-beginning) (region-end))
;;      (let ((bds (bounds-of-thing-at-point 'paragraph)) )
;;        (list nil (car bds) (cdr bds)) ) ) )

;;   (require 'xfrp_find_replace_pairs)

;;   (let (workOnStringP
;;         inputStr
;;         (charChangeMap [
;;                         ["á\\|à\\|â\\|ä\\|ã\\|å" "a"]
;;                         ["é\\|è\\|ê\\|ë" "e"]
;;                         ["í\\|ì\\|î\\|ï" "i"]
;;                         ["ó\\|ò\\|ô\\|ö\\|õ\\|ø" "o"]
;;                         ["ú\\|ù\\|û\\|ü"     "u"]
;;                         ["Ý\\|ý\\|ÿ"     "y"]
;;                         ["ñ" "n"]
;;                         ["ç" "c"]
;;                         ["ð" "d"]
;;                         ["þ" "th"]
;;                         ["ß" "ss"]
;;                         ["æ" "ae"]
;;                         ])
;;         )
;;     (setq workOnStringP (if ξfrom nil t))
;;     (setq inputStr (if workOnStringP ξstring (buffer-substring-no-properties ξfrom ξto)))
;;     (if workOnStringP
;;         (let ((case-fold-search t)) (replace-regexp-pairs-in-string inputStr charChangeMap) )
;;       (let ((case-fold-search t)) (replace-regexp-pairs-region ξfrom ξto charChangeMap) )) ) )
;; ;; * org-protocol with conkeror
;; ;; ;; the 'w' corresponds with the 'w' used before as in:
;; ;;   emacsclient \"org-protocol:/capture:/w/  [...]
;; (setq org-capture-templates
;;       '(
;; 	("w" "" entry ;; 'w' for 'org-protocol'
;; 	 (file+headline "www.org" "Notes")
;; 	 "* %^{Title}\nSource: %u, %c\n%i")
;; 	("x" "" entry ;; 'w' for 'org-protocol'
;; 	 (file+headline "clisp.org" "Notes")
;; 	 "* %^{Title}\nSource: %u, %l\n%i")
;; 	;;       "* %c%?\nSource: %u, %l\n%i")
;; 	;; other templates
;; 	))
;; * sanitize
;; (defun sanitize()
;;   (interactive)
;;  (save-excursion
;;     (goto-char (point-min)) (query-replace-regexp "\\<faut il\\>"  "faut-il")
;;     (goto-char (point-min)) (query-replace-regexp "\\<dites moi\\>"  "dites-moi")
;;     (goto-char (point-min)) (query-replace-regexp "\\<dites vous\\>"  "dites-vous")
;;     (goto-char (point-min)) (query-replace-regexp "\\<de façon naturel\\>"  "de façon naturelle")
;;     (goto-char (point-min)) (query-replace-regexp "\\<sus\\>"  "suis")
;;     (goto-char (point-min)) (query-replace-regexp "\\<sut\\>"  "sur")
;;     (goto-char (point-min)) (query-replace-regexp "\\<raton\\>"  "rayon")
;;     (goto-char (point-min)) (query-replace-regexp "\\<j'en met\\>"  "j'en mets")
;; ;;    (goto-char (point-min)) (query-replace-regexp "\\<d'une\\>"  "d'en")
;;     (goto-char (point-min)) (query-replace-regexp "\\<l'avant bras\\>"  "l'avant-bras")
;;     (goto-char (point-min)) (query-replace-regexp "\\<que faites vous\\>"  "que faites-vous")
;;     (goto-char (point-min)) (query-replace-regexp "manoeuvre"  "manœuvre")
;;     (goto-char (point-min)) (query-replace-regexp "oeuvre"  "œuvre")
;;     (goto-char (point-min)) (query-replace-regexp "soeur"  "sœur")
;;     (goto-char (point-min)) (query-replace-regexp "coeur"  "cœur")
;;     (goto-char (point-min)) (query-replace-regexp "boeuf"  "bœuf")
;;     (goto-char (point-min)) (query-replace-regexp "\\<oeil\\>"  "œil")
;;     (goto-char (point-min)) (query-replace-regexp "\\<l'oeil\\>"  "l'œil")
;;     (goto-char (point-min)) (query-replace-regexp "\\<quelque fois\\>"  "quelques fois")
;;     (goto-char (point-min)) (query-replace-regexp "\\<ça ça\\>"  "ça, ça")
;;     (goto-char (point-min)) (query-replace-regexp "\\<li\\>"  "il")
;; ;;    (goto-char (point-min)) (query-replace-regexp "\\([^0-9\\(trois\\|quatre\\|cinq\\|deux\\)]\\) \\<ans\\>"  "\\1 dans")
;; ;;    (goto-char (point-min)) (query-replace-regexp "\\<ne \\([,.]*\\) pas\\>"  "en")
;;     (goto-char (point-min)) (query-replace-regexp "\\<sauré\\>"  "sauté")
;;     (goto-char (point-min)) (query-replace-regexp "\\<quo\\>"  "qui")
;;     (goto-char (point-min)) (query-replace-regexp "\\<no\\>"  "on")
;;     (goto-char (point-min)) (query-replace-regexp "\\<\\([^t][^u]\\) as\\>"  "\\1 pas")
;;     (goto-char (point-min)) (query-replace-regexp "\\<in\\>"  "un")
;;     (goto-char (point-min)) (query-replace-regexp "\\<ales\\>"  "a les")
;;     (goto-char (point-min)) (query-replace-regexp "\\<ale\\>"  "a le")
;;     (goto-char (point-min)) (query-replace-regexp "\\<fat\\>"  "faut")
;;     (goto-char (point-min)) (query-replace-regexp "\\<aune\\>"  "a une")
;;     (goto-char (point-min)) (query-replace-regexp "\\<une je\\>"  "que je")
;;     (goto-char (point-min)) (query-replace-regexp "\\<sil\\>"  "s il")
;;     (goto-char (point-min)) (query-replace-regexp "\\<in\\>"  "un")
;;     (goto-char (point-min)) (query-replace-regexp "moi même"  "moi-même")
;;     (goto-char (point-min)) (query-replace-regexp "quand même"  "quand-même")
;;     (goto-char (point-min)) (query-replace-regexp "toi même"  "toi-même")
;;     (goto-char (point-min)) (query-replace-regexp "lui même"  "lui-même")
;;     (goto-char (point-min)) (query-replace-regexp "soi même"  "soi-même")
;;     (goto-char (point-min)) (query-replace-regexp "\\<eux même\\>"  "eux-mêmes")
;;     (goto-char (point-min)) (query-replace-regexp "vous même"  "vous-même")
;;     (goto-char (point-min)) (query-replace-regexp "nous même"  "nous-même")
;;     (goto-char (point-min)) (query-replace-regexp "là bas"  "là-bas")
;;     (goto-char (point-min)) (query-replace-regexp "au delà"  "au-delà")
;;     (goto-char (point-min)) (query-replace-regexp "au dessus"  "au-dessus")
;;     (goto-char (point-min)) (query-replace-regexp "après vente"  "après-vente")
;;     (goto-char (point-min)) (query-replace-regexp "libre service"  "libre-service")
;;     (goto-char (point-min)) (query-replace-regexp "\\<n y\\>"  "n'y")
;;     (goto-char (point-min)) (query-replace-regexp "là dedans"  "là-dedans")
;;     (goto-char (point-min)) (query-replace-regexp "là dessus"  "là-dessus")
;;     (goto-char (point-min)) (query-replace-regexp "là dessous"  "là-dessous")

;;     (goto-char (point-min)) (query-replace-regexp "\\<ce \\([^ ]*\\) là\\>"  "ce \\1-là")
;;     (goto-char (point-min)) (query-replace-regexp "\\<ce \\([^ ]*\\) ci\\>"  "ce \\1-ci")
;;     (goto-char (point-min)) (query-replace-regexp "\\<ces \\([^ ]*\\) là\\>"  "ces \\1-là")
;;     (goto-char (point-min)) (query-replace-regexp "\\<cette \\([^ ]*\\) là\\>"  "cette \\1-là")
;;     (goto-char (point-min)) (query-replace-regexp "\\<cet \\([^ ]*\\) là\\>"  "cet \\1-là")
;;     (goto-char (point-min)) (query-replace-regexp "celui là"  "celui-là")
;;     (goto-char (point-min)) (query-replace-regexp "celui ci"  "celui-ci")
;;     (goto-char (point-min)) (query-replace-regexp "celle ci"  "celle-ci")
;;     (goto-char (point-min)) (query-replace-regexp "celle là"  "celle-là")
;;     (goto-char (point-min)) (query-replace-regexp "je me suis dis"  "je me suis dit")
;;     ;;(goto-char (point-min)) (query-replace-regexp "\\<n y a"  "n'y a")
;;     (goto-char (point-min)) (query-replace-regexp "a t elle\\>"  "a-t-elle")
;;     (goto-char (point-min)) (query-replace-regexp "a t il\\>"  "a-t-il")
;;     (goto-char (point-min)) (query-replace-regexp "\\<a t il\\>"  "a-t-il")
;;     (goto-char (point-min)) (query-replace-regexp " t il\\>"  "-t-il")
;;     (goto-char (point-min)) (query-replace-regexp "\\<est ce que\\>"  "est-ce que")
;;     (goto-char (point-min)) (query-replace-regexp "\\<qu'est ce que\\>"  "qu'est-ce que")
;;     (goto-char (point-min)) (query-replace-regexp "\\<ils on\\>"  "ils ont")
;;     (goto-char (point-min)) (query-replace-regexp "\\<te\\>"  "et")
;;     (goto-char (point-min)) (query-replace-regexp "\\<et là "  "et là, ")
;;     (goto-char (point-min)) (query-replace-regexp "\\<je \\([^ ]*\\)end pas\\>"  "je ne \\1ends pas")
;;     (goto-char (point-min)) (query-replace-regexp "\\<je ne \\([^ ]*\\)end pas\\>"  "je ne \\1ends pas")
;;     (goto-char (point-min)) (query-replace-regexp "\\<je \\([^ ]*\\)end\\>"  "je \\1ends")
;;     (goto-char (point-min)) (query-replace-regexp "\\<je ne prend\\>"  "je ne prends")
;;     (goto-char (point-min)) (query-replace-regexp "\\<j'ai fais\\>"  "j'ai fait")
;;     (goto-char (point-min)) (query-replace-regexp "\\<je l'ai fais\\>"  "je l'ai fait")
;;     (goto-char (point-min)) (query-replace-regexp "\\<j'en ai fais\\>"  "j'en ai fait")
;;     (goto-char (point-min)) (query-replace-regexp "\\<je met\\>"  "je mets")
;;     (goto-char (point-min)) (query-replace-regexp "\\<j'ai dis\\>"  "j'ai dit")
;;     (goto-char (point-min)) (query-replace-regexp "\\<j'ai fais\\>"  "j'ai fait")
;;     (goto-char (point-min)) (query-replace-regexp "\\<c'est pas\\>"  "ce n'est pas")
;;     (goto-char (point-min)) (query-replace-regexp "\\<j'ai pas\\>"  "je n'ai pas")
;;     (goto-char (point-min)) (query-replace-regexp "\\<je \\([^ ]*\\)ait\\>"  "je \\1ais")
;;     (goto-char (point-min)) (query-replace-regexp "\\<je \\([^n ][^' ][^ ]*\\) pas\\>"  "je ne \\1 pas")
;;     (goto-char (point-min)) (query-replace-regexp "\\<je ne \\([^ ]*\\)ait\\>"  "je ne \\1ais")
;;     (goto-char (point-min)) (query-replace-regexp "\\<j'\\([^ ]*\\) pas\\> "  "je n'\\1 pas")
;;     (goto-char (point-min)) (query-replace-regexp "\\<t'\\([^ ]*\\) pas\\> "  "tu n'\\1 pas")
;;     (goto-char (point-min)) (query-replace-regexp "\\([^ ]ez\\)\\ \\(vous\\)"  "\\1-\\2")
;;     (goto-char (point-min)) (query-replace-regexp "\\<ça \\([^ ]*[^m]\\)ais\\>"  "ça \\1ait")
;;     (goto-char (point-min)) (query-replace-regexp " '\\(\\w\\)"  " \\1'")
;;     (goto-char (point-min)) (query-replace-regexp "\\<\\([^ ]*ez\\) moi\\>"  "\\1-moi")
;;     (goto-char (point-min)) (query-replace-regexp "\\<à \\([^ ]*\\)é\\>"  "à \\1er")
;;     (goto-char (point-min)) (query-replace-regexp "\\<lui même\\>"  "lui-même")
;;     (goto-char (point-min)) (query-replace-regexp "\\<elle même\\>"  "elle-même")
;;     (goto-char (point-min)) (query-replace-regexp "\\<cendre\\>"  "vendre")

;; ;;     (goto-char (point-min)) (query-replace-regexp "\\<les \\([^
;; ;; ]*[^\\(
;; ;; \\|er\\|ir\\|ez\\|endre\\|s\\|x\\|it\\)0-9]\\)\\>"  "les \\1s")
;; ;;     (goto-char (point-min)) (query-replace-regexp "\\<des \\([^
;; ;; ]*[^\\(
;; ;; \\|er\\|ir\\|ez\\|endre\\|s\\|x\\|it\\)0-9]\\)\\>"  "des \\1s")
;; ;;     (goto-char (point-min)) (query-replace-regexp "\\<mes \\([^
;; ;; ]*[^\\(
;; ;; \\|er\\|ir\\|ez\\|endre\\|s\\|x\\|it\\)0-9]\\)\\>"  "mes \\1s")
;; ;;     (goto-char (point-min)) (query-replace-regexp "\\<tes \\([^
;; ;; ]*[^\\(
;; ;; \\|er\\|ir\\|ez\\|endre\\|s\\|x\\|it\\)0-9]\\)\\>"  "tes \\1s")
;; ;;     (goto-char (point-min)) (query-replace-regexp "\\<ses \\([^
;; ;; ]*[^\\(
;; ;; \\|er\\|ir\\|ez\\|endre\\|s\\|x\\|it\\)0-9]\\)\\>"  "ses \\1s")
;; ;;     (goto-char (point-min)) (query-replace-regexp "\\<leurs \\([^
;; ;; ]*[^\\(
;; ;; \\|er\\|ir\\|ez\\|endre\\|s\\|x\\|it\\)0-9]\\)\\>"  "leurs \\1s")
;; ;;     (goto-char (point-min)) (query-replace-regexp "\\<nos \\([^
;; ;; ]*[^\\(
;; ;; \\|er\\|ir\\|ez\\|endre\\|s\\|x\\|it\\)0-9]\\)\\>"  "nos \\1s")
;; ;;     (goto-char (point-min)) (query-replace-regexp "\\<vos \\([^
;; ;; ]*[^\\(
;; ;; \\|er\\|ir\\|ez\\|endre\\|s\\|x\\|it\\)0-9]\\)\\>"  "vos \\1s")

;;     (goto-char (point-min)) (replace-regexp "\\<[^aày0-9A-Z%]\\>"  "\\?")
;;     )
;;   )
;; * zap up to char
(autoload 'zap-up-to-char "misc"
    "Kill up to, but not including ARGth occurrence of CHAR.

  \(fn arg char)"
    'interactive)
(global-set-key "\M-z" 'zap-up-to-char)

;; * dired jump
(defun dired-jump-and-kill()
  (interactive)
  (setq tokill (current-buffer))
  (dired-jump)
  (kill-buffer tokill))
(global-set-key			(kbd "C-x C-j")	'dired-jump-and-kill)
;; * yank-to-x-clipboard
(defun yank-to-x-clipboard ()
  (interactive)
  (if (region-active-p)
        (progn
	  (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
	  (clipboard-kill-ring-save (region-beginning) (region-end))
	  (message "Yanked region to clipboard!")
	  (deactivate-mark))
    (message "No region active; can't yank to clipboard!")))

;(global-set-key "\M-w" 'yank-to-x-clipboard)


;; * browse with conkeror OFF
;; (setq browse-url-generic-program (executable-find "conkeror"))
;; (setq browse-url-browser-function 'browse-url-generic)
;; ;; * mkdir
;; (defun mdr()
;; (interactive)
;; (dired-create-directory (format-time-string "%y%m%d%H%M%S")))
;; ;; * screencast
;; (defun bs()
;;   (interactive)
;;   (start-process "ScreenCast" "*ScreenCastBuffer*" "~/bin/recordmd")
;;   (sleep-for 1.2)
;;   (attachspeaker)
;;   )

;; (defun as()
;;   (interactive)
;;   (call-process "jack_connect" nil "*scratch*" nil "system:capture_1" "ffmpeg:input_1")
;;   (call-process "jack_connect" nil "*scratch*" nil "system:capture_2" "ffmpeg:input_2"))

;; (defun ds()
;;   (interactive)
;;   (call-process "jack_disconnect" nil "*scratch*" nil "system:capture_1" "ffmpeg:input_1")
;;   (call-process "jack_disconnect" nil "*scratch*" nil "system:capture_2" "ffmpeg:input_2"))

;; (defun ss()
;;   (interactive)
;;   (delete-process "ScreenCast"))
;; ;; * colorful hex
;;  (defvar hexcolour-keywords
;;    '(("#[abcdef[:digit:]]\\{6\\}"
;;       (0 (put-text-property (match-beginning 0)
;;                             (match-end 0)
;;                             'face (list :background
;;                                         (match-string-no-properties 0)))))))

;;  (defun hexcolour-add-to-font-lock ()
;;    (font-lock-add-keywords nil hexcolour-keywords))
;;  (add-hook 'conf-space-mode-hook 'hexcolour-add-to-font-lock)
;; ;; * open folder in xdg-open
;; (defun thunar ()
;;   "Show current file in desktop (OS's file manager)."
;;   (interactive)
;;   (cond
;;    ((string-equal system-type "windows-nt")
;;     (w32-shell-execute "explore" (replace-regexp-in-string "/" "\\" default-directory t t)))
;;    ((string-equal system-type "darwin") (shell-command "open ."))
;;    ((string-equal system-type "gnu/linux")
;;     (let ((process-connection-type nil)) (start-process "" nil "thunar" "."))
;;     ;; (shell-command "xdg-open .") ;; 2013-02-10 this sometimes froze emacs till the folder is closed. ⁖ with nautilus
;;     ) ))

;; ;; * fonts
;; (set-fontset-font
;;    "fontset-default"
;;    (cons (decode-char 'ucs #x0600) (decode-char 'ucs #x06ff)) ; arabic
;;    "DejaVu Sans Mono")


;; ;; ** M-x pour droitier altG-!
;; (global-set-key (kbd "¡") 'execute-extended-command)
;; (global-set-key "÷" ctl-x-map)
;; ;; * entourer la selection de tags
;; (defun entour (start end)
;;   "Copy to the kill ring a string in the format \"file-name:line-number\"
;; for the current buffer's file name, and the line number at point."
;;   (interactive "r")
;;   (goto-char end)
;;   (insert "@@html:</span>@@")
;;   (goto-char start)
;;   (insert "@@html:<span class=\"bg-danger\">@@")

;;   )


;; ;; * emamux

;; (defun aziz:send-command (b e)
;;   "Send command to target-session of tmux"
;;   (interactive "r")
;;   (emamux:check-tmux-running)
;;   (condition-case nil
;;       (progn
;;         (if (or current-prefix-arg (not (emamux:set-parameters-p)))
;;             (emamux:set-parameters))
;;         (let* ((target (emamux:target-session))
;;                (prompt (format "Command [Send to (%s)]: " target))
;;                (input  (buffer-substring-no-properties b e)))
;;           (emamux:reset-prompt target)
;;           (emamux:send-keys input)))
;;       (quit (emamux:unset-parameters))))
;; ;; * dash
;; ;(setq helm-dash-browser-func 'w3m)
;; ;; * auto update dired
;; (setq global-auto-revert-non-file-buffers t)
;; (setq auto-revert-verbose nil)
;; ;(setq-default truncate-lines t)
;; ;; * meteo
;; (setq sunshine-location "Mostaganem, DZ"
;;       sunshine-units 'metric)
;; ;; * jabber facebook-gmail-chat moved to credential.el
;; ;; * twitter
;; (add-hook 'twittering-new-tweets-hook (lambda ()
;;    (let ((n twittering-new-tweets-count))
;;      (start-process "twittering-notify" nil "notify-send"
;;             ;        "-i" "/usr/share/pixmaps/gnome-emacs.png"
;;                     "New tweets"
;;                     (format "You have %d new tweet%s"
;;                             n (if (> n 1) "s" ""))))))

;; (setq twittering-use-master-password t)
;; (setq twittering-icon-mode t)                ; Show icons
;; (setq twittering-timer-interval 120)         ; Update your timeline each 300 seconds (5 minutes)
;; (setq twittering-url-show-status nil)        ; Keeps the echo area from showing all the http processes
;; (setq twittering-tinyurl-service 'bit.ly)
;; (setq twittering-bitly-login "o_5n5e8dfc89")
;; (setq twittering-bitly-api-key "R_62853b37260e4f7ba117510a053414a1")


;; (setq browse-url-generic-program (executable-find "conkeror"))
;; (setq browse-url-browser-function 'browse-url-generic)
;; ; (setq browse-url-browser-function (quote w3m-browse-url))
;; ; (setq browse-url-new-window-flag t)
;; (add-hook 'twittering-edit-mode-hook (lambda () (ispell-minor-mode) (flyspell-mode)))
;; (autoload 'twittering-numbering "twittering-numbering" nil t)
;; (add-hook 'twittering-mode-hook 'twittering-numbering)

;; ;; * ace-jump
;; (add-to-list 'load-path "/home/aziz/.emacs.d/addons/")
;; (autoload
;;   'ace-jump-mode
;;   "ace-jump-mode"
;;   "Emacs quick move minor mode"
;;   t)
;; ;; you can select the key you prefer to
;; (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;; ;; * skype
;; ;; (add-to-list 'load-path "~/.emacs.d/addons/skype/")
;; ;; (require 'skype)
;; ;; (setq skype--my-user-handle "azizyemloul")

;; ;; * auto-complete-elisp
;; ;    (require 'ac-slime)
;;     (add-hook 'slime-mode-hook 'set-up-slime-ac)
;;     (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
;;     (eval-after-load "auto-complete"
;;       '(add-to-list 'ac-modes 'slime-repl-mode))
;; ;; * emoji
;; ;(require 'company-emoji)
;; ;

;; ;(add-to-list 'company-backends 'company-emoji)
;; ;; * Git
;; (add-to-list 'load-path "/usr/share/git-core/emacs/")
;; (require 'git)
;; ;; * slime
;; ;(setq inferior-lisp-program "~/Bureau/ccl/lx86cl64")
;; ;; * stumpwm
;; (load "/home/aziz/.stumpwm.d/contrib/util/swm-emacs/stumpwm-mode.el")
;; ;; * grep $PATH into shell-command
;; (setq shell-command-switch "-c")
;; (require 'shell-command)
;; (shell-command-completion-mode)
;; ;; * common lisp/quicklisp integration
;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; (setq inferior-lisp-program "sbcl")
;; ;; * display apostrophe in stanford courses transcript
;; (standard-display-ascii ?\222 [?'])
;; (standard-display-ascii ?\223 [?\"])
;; (standard-display-ascii ?\224 [?\"])
;; (standard-display-ascii ?\226 [?-])


;; ;; * findtop
;; ;; [[gnus:nnimap%2Bgmail:org-mode#87si568pk8.fsf@gmail.com][Email from Myles English: Re: {O} Return Top-Level Headi]]
;; ;; > Is there a way to reference the top-level heading that a lower-level
;; ;; > heading belongs to? For instance:
;; ;; >
;; ;; > * One
;; ;; > ** Two
;; ;; > *** Three
;; ;; >
;; ;; > If I have "Three", how can I get it to tell me that the top-level is "One"?
;; ;; > For reference, this is for an org-agenda-prefix.

;; ;; Perhaps this:

;; (defun findTop()
;;     (interactive)
;;     (let* ((tree (org-element-parse-buffer))
;;            (curs_pos (point))
;;            (up_tree (org-element-map tree 'headline
;;                       (lambda (hl)
;;                         (and (> curs_pos (org-element-property :begin hl))
;;                              (= (org-element-property :level hl) 1)
;;                              (org-element-property :raw-value hl) ))))
;;            (local_up_tree (last up_tree)))
;;       local_up_tree))

;; ;;Myles
;; ;; * powerline
;; (require 'powerline)
;; ;(powerline-default-theme)
;; (powerline-center-theme)
