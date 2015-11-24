;; * init
(add-to-list 'auto-mode-alist		'("\\.org$"	. org-mode))
(setq
 org-agenda-include-diary		nil
 org-agenda-start-with-follow-mode	nil
 org-completion-use-iswitchb		t
 org-link-mailto-program		(quote (compose-mail "%a" "%s"))
 org-log-done				t
 org-mime-library			'mml
 org-return-follows-link		t
 org-src-fontify-natively		t
 org-tab-follows-link			t
 )
;; * hooks
(add-hook 'org-after-todo-statistics-hook	'org-summary-todo)
(add-hook 'org-agenda-mode-hook			'(lambda () (hl-line-mode 1)) 'append)
(add-hook 'org-agenda-mode-hook			(lambda () (define-key org-agenda-mode-map "q" 'bury-buffer)) 'append)
(add-hook 'org-mode-hook			(lambda () (local-set-key "\C-c\M-o" 'org-mime-org-buffer-htmlize)))
(add-hook 'org-mode-hook			'abbrev-mode)
;; * keys
(global-set-key			[f9]			'org-timer-change-times-in-region)
(global-set-key			[f5]			'org-clock-in)
(global-set-key			[f6]			'org-clock-out)
(define-key global-map		"\C-ct"			'org-toc-show)
(define-key global-map		"\C-ca"			'org-agenda)
(define-key global-map		"\C-co"			'org-mode)
;; * todosFaces
(setq org-todo-keyword-faces
      '(

	("TCON" . (:foreground "yellow" :background "magenta" :weight bold))
	("TODO" . (:foreground "yellow" :background "red" :weight bold))
	("PROG" . (:foreground "yellow" :background "blue" :weight bold))
	("DONE" . (:foreground "yellow" :background "green" :weight bold))
	("CLOS" . (:foreground "yellow" :background "black" :weight bold))

	)
      )
;; * ferd
(defun ferd()
  (interactive)
  (save-excursion
    (or (org-at-heading-p) (outline-previous-visible-heading 1))
    (setq
     tagg		(or (condition-case nil (upcase (substring (org-entry-get nil "TAGS") 1 -1)) (error nil)) "")
     jour		(format-time-string
			 "%d-%m-%Y" (or
				     (condition-case nil (org-time-string-to-time (org-entry-get nil "TIMESTAMP"))  (error nil))
				     (condition-case nil (org-time-string-to-time (org-entry-get nil "SCHEDULED"))  (error nil))
				     nil))
     fauxjour		(format-time-string "%Y-%m")
     header		(nth 4 (org-heading-components))
     horaire		(if (string-match "\\([0-9]\\{2\\}:[0-9]\\{2\\}-[0-9]\\{2\\}:[0-9]\\{2\\}\\)"  header) (match-string 1 header) "")
     heureh		(replace-regexp-in-string ":" "h" horaire)


     nomdereunion	(trim-string (replace-regexp-in-string horaire "" header))
     nomdereunion	(trim-string (replace-regexp-in-string (org-re-timestamp 'active) "" nomdereunion))
     entete		(trim-string (replace-regexp-in-string "  " " " (concat tagg " " jour " " heureh " " nomdereunion)))
     nom_de_fichier	(concat entete ".org")
     path-atelier-courant (concat "~/org/ateliers/" fauxjour "/")
     location_fichier	(concat path-atelier-courant nom_de_fichier)
     lien_fichier	(concat "[[file://" location_fichier "][" nom_de_fichier "]]")
     )
    (org-todo)
    (org-entry-put nil "LINK" lien_fichier)
    (if (file-exists-p path-atelier-courant)
	(find-file-noselect location_fichier)
      (progn
	(make-directory path-atelier-courant)
	(find-file-noselect location_fichier)))
    (if    (re-search-forward "\\*\\* Intro" (point-max) t)
	(progn
	  (setq intro (line-beginning-position))
	  (append-to-buffer nom_de_fichier  intro (point-max))))
    (switch-to-buffer nom_de_fichier)
    (goto-char 0)
    (insert (concat "* " entete "\n"))
    (goto-char 0)
    (flush-lines "\\(CLOSED:\\|:PROPERTIES:\\|:ORIGIN:\\|:CHEMIN:\\|:MEDIAS:\\|:Effort:\\|:END:\\|:LOGBOOK:\\|CLOCK:\\)")
    (correction)
   )
  )
;; * insertTime
(defun insert-time ()
  "Insert date at point."
  (interactive)
  (insert (format-time-string "\n- %H:%M:%S :: ")))
;; * littleDd
(defun dd()
"alias for (goto-char (point-min))"
  (interactive)
  (goto-char (point-min)))
;; * littleGg
(defun gg()
"alias for (goto-char (point-max))"
  (interactive)
  (goto-char (point-max)))
;; * removeDuplicates
(defun strip-duplicates (list)
  (let ((new-list nil))
    (while list
      (when (and (car list) (not (member (car list) new-list)))
        (setq new-list (cons (car list) new-list)))
      (setq list (cdr list)))
    (nreverse new-list)))
;; * ancestor
(defun ancestor()
  "Retourne le parent de l'entête courant
Retourne le nom du fichier si l'entête courant n'a pas d'ancêtre"
  (interactive)
  (save-excursion
    (cond
      ((condition-case nil (outline-up-heading 1) (error nil)) (setq x (nth 4 (org-heading-components))))
      (t                                                       (setq x (concat "file:" (file-name-nondirectory (buffer-file-name)))))))
  (message x)
  x)
;; * parent
(defun parent()
  "Retourne l'entête courant
Retourne le nom du fichier si l'emplacement n'a pas de parent. "
  (interactive)
  (save-excursion
    (cond
     ((org-on-heading-p)                                        (setq x  (nth 4 (org-heading-components))))
     ((search-backward-regexp org-complex-heading-regexp nil t) (setq x  (nth 4 (org-heading-components))))
     (t                                                         (setq x (concat "file:" (file-name-nondirectory (buffer-file-name)))))
     ))
  (message x)
  x)
;; * contenu
(defun contenu()
  "Retourne le contenu de l'entête courant.
Retourne le contenu depuis début du fichier
jusqu'au premier entête si le point est avant le premier entête du fichier "
  (interactive)
  (setq complex-heading-regexp
	"^\\(\\*+\\)\\(?: +\\(TODO\\|DONE\\)\\)?\\(?: +\\(\\[#.\\]\\)\\)?\\(?: +\\(.*?\\)\\)??\\(?:[ 	]+\\(:[[:alnum:]_@#%:]+:\\)\\)?[ 	]*$")
  (save-excursion
    (cond
     ((org-on-heading-p)                                          (setq x (line-end-position)))
     ((search-backward-regexp complex-heading-regexp nil t)       (setq x (line-end-position)))
     (t                                                           (setq x (point-min)))
     )
    (outline-next-visible-heading 1)
    (setq y (point))
    (buffer-substring-no-properties x y)))

;; * listLineContainingRegexp
(defun list-line-containing-regexp(reg)
"Prend une expression régulière et retourne les lignes correpondantes dans une liste"
  (interactive)
  (setq collection '())
  (save-excursion
    (while    (search-forward-regexp reg nil t)
      (add-to-list 'collection (buffer-substring-no-properties (line-beginning-position) (line-end-position)))))
  (reverse collection))
;; * replaceRegexpNlist
(defun replace-regexp-nlist(list)
  (interactive)
  (mapcar
   (lambda(x)
     (dd)
     (replace-regexp (nth 0 x) (nth 1 x))
     (while (search-forward "@" nil t) (replace-match "~" nil t))
     )
   list))

;; * extractDuplicates
  (defun uniquify-all-lines-region (start end)
    "Find duplicate lines in region START to END keeping first occurrence."
    (interactive "*r")
    (save-excursion
      (let ((end (copy-marker end)))
        (while
            (progn
              (goto-char start)
              (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
          (replace-match "\\1\n\\2")))))

  (defun uniquify-all-lines-buffer ()
    "Delete duplicate lines in buffer and keep first occurrence."
    (interactive "*")
    (uniquify-all-lines-region (point-min) (point-max)))
;; * trimString
(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
(replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string))
)
