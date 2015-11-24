;; * keys
(define-key global-map		"\C-cp"			'flyspell-mode)
;; (define-key global-map		"\C-cf"			'flyspell-buffer)
;; (define-key global-map		"\C-cc"			'flyspell-goto-next-error)
;; (define-key global-map		"\C-cv"			'ispell-word)
;; * backupThisFile
(defun backup-this-file ()
  "Make a backup of current file."
  (interactive)
  (setq
   backup-directory (concat "~/org/backup/" (format-time-string "%m-%y") "/")
   meta (format-time-string "%d-%m_%Hh%M")
   prprt (format-time-string "%Hh%M")
   this-file (file-name-nondirectory (buffer-file-name))
   new-name (concat backup-directory meta "§" this-file)
   lien_fichier (concat "[[file:/" new-name "][" meta "]]")
   )
  (if (string= "org-mode" (symbol-name major-mode))
      (save-excursion
	(find-file-other-window "~/org/diary.org")
	(widen)
	(goto-char (point-min))
	(search-forward this-file nil t)
	(org-entry-add-to-multivalued-property nil "BACKUPS" lien_fichier))
    (message "You're not in org-mode\nNo link will be put for this file"))
  (if (file-exists-p backup-directory)
      (copy-file (buffer-file-name) new-name 1)
    (progn
      (make-directory backup-directory)
      (copy-file (buffer-file-name) new-name 1)))
  )
;; * correction
(defun correction()
  "Mise en forme et début de la correction manuelle."
  (interactive)
;  (condition-case nil (backup-this-file) (error nil))
  (dd)
					; les questions
  (save-excursion
    (replace-regexp "^- \\([0-9][0-9]:\\)" "+ \\1")
    (dd)
    (replace-string "=" "\n+"))
					;les réponses
  (mapcar (lambda (list)
	    (save-excursion
	      (replace-string (car list) (cadr list))))
	  '(
	    ("@" "~")
	    ("&&" "~")
	    ("&" "\n")
	    ("~" "&")
	    ("&" "\n&")
	    (" é " "\né ")
	    (" \" " "\n\" ")
	    (" ' " "\n' ")
	    (" ( " "\n( ")
	    (" - " "\n- ")
	    (" è " "\nè ")
	    (" _ " "\n_ ")
	    (";" ".") ;; ponct
	    )
	  )
					; espaces et ponctuations
  (delete-trailing-whitespace)
  (flush-lines "^$" (point-min) (point-max) nil)
  (mapcar (lambda (list)
	    (save-excursion
	      (replace-regexp (car list) (cadr list))))
	  '(
	    ("^[\t ]*" "") ;; extraspaces
	    ("  *" " ")
	    (" *," ",")
	    (" *\\." ".")
	    ("^\\([^*+].*\\)\\([^?\n]\\)$" "\\1\\2.") ;;lineendpoint
	    ("^\\([0-9A-Z]\\)$" "\\1.") ;; orphelines pointe
	    (",,,*" "...")
	    (";;*" " ;")
	    (" *!" " !")
	    (" *\\?" " ?")
	    (" +:\\([^: ]\\)" " : \\1")
	    )
	  )
					;nommage
  (mapcar (lambda(x)
	    (save-excursion
	      (re-search-forward x nil t)
	      (setq z (progn (re-search-forward "\\(\\w+\\)") (match-string 1)))
	      (dd) (replace-regexp x (concat z " : ")))
	    )
	  '("^& " "^é " "^\" " "^' " "^( " "^- " "^è " "^_ "))
					;saut de ligne final
  (save-excursion (replace-regexp "+ \\(.*\\)" "\n- \\1 ?"))
  (save-buffer)
  (visual-line-mode)
  (flyspell-mode)
  (flyspell-buffer)
;  (local-set-key	"œ"		'flyspell-goto-next-error)
;  (local-set-key	"\C-z"		'transpose-chars)
  )

;; * enleverLHheure
(defun enlevlr()
  (interactive)
  (save-excursion
    (replace-regexp "^- [0-9:]* :: " "") (point-min) (point-max)))
;; * sanitize
(defun sanitize()
  (interactive)
  (setq louis
	'(
;; ** œ
	  ("boeuf"  "bœuf" t)
	  ("coeur"  "cœur" t)
	  ("manoeuvre"  "manœuvre" t)
	  ("oeil"  "œil" t)
	  ("oeuvre"  "œuvre" t)
	  ("soeur"  "sœur" t)

;; ** tiret interrogation
	  (" t il\\>"  "-t-il")
	  ("\\([^ ]ez\\)\\ \\(vous\\)"  "\\1-\\2")
	  ("\\<a t il\\>"  "a-t-il")
	  ("\\<dites moi\\>"  "dites-moi")
	  ("\\<dites vous\\>"  "dites-vous")
	  ("\\<est ce que\\>"  "est-ce que" t)
	  ("\\<faut il\\>"  "faut-il")
	  ("\\<qu'est ce que\\>"  "qu'est-ce que")
	  ("\\<que faites vous\\>"  "que faites-vous")
	  ("a t elle\\>"  "a-t-elle")

;; ** trait d'union
	  ("\\<au dela\\>"  "au-delà" t)
	  ("\\<elle même\\>"  "elle-même")
	  ("\\<eux même\\>"  "eux-mêmes")
	  ("\\<l'avant bras\\>"  "l'avant-bras" t)
	  ("\\<lui même\\>"  "lui-même")
	  ("après vente"  "après-vente")
	  ("\\<au delà\\>"  "au-delà" t)
	  ("au dessus"  "au-dessus")
	  ("libre service"  "libre-service")
	  ("lui même"  "lui-même")
	  ("là bas"  "là-bas" t)
	  ("là dedans"  "là-dedans" t)
	  ("là dessous"  "là-dessous" t)
	  ("là dessus"  "là-dessus" t)
	  ("moi même"  "moi-même")
	  ("nous même"  "nous-même")
	  ("quand même"  "quand-même" t)
	  ("soi même"  "soi-même")
	  ("toi même"  "toi-même")
	  ("vous même"  "vous-même")

;; ** tiret démonstratif
	  ("\\<ce \\([^ ]*\\) ci\\>"  "ce \\1-ci" t)
	  ("\\<ce \\([^ ]*\\) là\\>"  "ce \\1-là" t)
	  ("\\<ces \\([^ ]*\\) là\\>"  "ces \\1-là" t)
	  ("\\<cet \\([^ ]*\\) là\\>"  "cet \\1-là" t)
	  ("\\<cette \\([^ ]*\\) là\\>"  "cette \\1-là" t)
	  ("celle ci"  "celle-ci" t)
	  ("celle là"  "celle-là" t)
	  ("celui ci"  "celui-ci" t)
	  ("celui là"  "celui-là" t)
	  ("celles ci"  "celles-ci" t)
	  ("celles là"  "celles-là" t)
	  ("ceux ci"  "ceux-ci" t)
	  ("ceux là"  "ceux-là" t)

;; ** fautes invisibles à l'orthographe
	  ("\\<pe\\>"  "peut-être")
	  (" '\\(\\w\\)"  " \\1'")
	  ("\\([^0-9]\\) \\<ans\\>"  "\\1 dans")
	  ("\\([^t][^u]\\) es\\>"  "\\1 les")
	  ("\\<\\([^t][^u]\\) as\\>"  "\\1 pas")
	  ("\\<ale\\>"  "a le")
	  ("\\<ales\\>"  "a les")
	  ("\\<aune\\>"  "a une")
	  ("\\<cendre\\>"  "vendre")
	  ("\\<dt\\>"  "produit")
	  ("\\<fat\\>"  "faut")
	  ("\\<ils on\\>"  "ils ont")
	  ("\\<in\\>"  "un")
	  ("\\<li\\>"  "il")
	  ("\\<no\\>"  "on")
	  ("\\<quo\\>"  "qui")
	  ("\\<raton\\>"  "rayon")
	  ("\\<sauré\\>"  "sauté")
	  ("\\<sil\\>"  "s il")
	  ("\\<sus\\>"  "suis")
	  ("\\<sut\\>"  "sur")
	  ("\\<te\\>"  "et")
	  ("\\<une je\\>"  "que je")

;; ** conjugaison premiere personne du singulier
	  ("\\<j'\\([^ ]*\\) pas\\>"  "je n'\\1 pas")
	  ("\\<j'ai dis\\>"  "j'ai dit" t)
	  ("\\<j'ai fais\\>"  "j'ai fait" t)
	  ("\\<j'ai pas\\>"  "je n'ai pas" t)
	  ("\\<j'en ai fais\\>"  "j'en ai fait" t)
	  ("\\<j'en met\\>"  "j'en mets" t)
	  ("\\<je \\([^ ]*\\)ait\\>"  "je \\1ais")
	  ("\\<je \\([^ ]*\\)end pas\\>"  "je ne \\1ends pas")
	  ("\\<je \\([^ ]*\\)end\\>"  "je \\1ends")
	  ("\\<je l'ai fais\\>"  "je l'ai fait" t)
	  ("\\<je me suis dis\\>"  "je me suis dit" t)
	  ("\\<je met\\>"  "je mets" t)
	  ("\\<je ne \\([^ ]*\\)ait\\>"  "je ne \\1ais")
	  ("\\<je ne \\([^ ]*\\)end pas\\>"  "je ne \\1ends pas")
	  ("\\<je ne prend\\>"  "je ne prends" t)

;; ** conjugaison 3e personne
	  ("\\<ça \\([^ ]*[^m]\\)ais\\>"  "ça \\1ait")

;; ** accords pluriels et féminins
	  ("\\<quelque fois\\>"  "quelques fois" t)
	  ("\\<de façon naturel\\>"  "de façon naturelle" t)

;; ** virgules
	  ("\\<et là "  "et là, " t)
	  ("\\<ça ça\\>"  "ça, ça" t)

;; ** négations
	  ;; ("\\<c'est pas\\>"  "ce n'est pas" t)
	  ;; ("\\<je \\([^n ][^' ][^ ]*\\) pas \\([^m][^a][^l]\\)\\>"  "je ne \\1 pas \\2")
	  ("\\<n y\\>"  "n'y" t)
	  ;; ("\\<t'\\([^ ]*\\) pas\\> "  "tu n'\\1 pas")

;; ** lettres orphelines
	  ("\\<[^aày0-9A-Z%]\\>"  "\\?" t)
	  )
	)

;; ** fonction sanitize
  (while louis
    (dd)
    (setq y (pop louis))
    (if (caddr y)
	(replace-regexp (car y) (cadr y))
      (query-replace-regexp (car y) (cadr y)))
    )
  )
