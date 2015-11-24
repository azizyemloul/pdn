;; * capitales
(defun capitales()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "^\\(\\w\\)" nil t)
      (replace-match (capitalize (match-string 1))))
    (goto-char (point-min))
    (while (re-search-forward ":: \\(\\w\\)" nil t)
      (replace-match (concat ":: " (capitalize (match-string 1)))))
    (goto-char (point-min))
    (while (re-search-forward "^- \\(\\w\\)" nil t)
      (replace-match (concat "- " (capitalize (match-string 1)))))
    (goto-char (point-min))
    (while (re-search-forward " : \\(\\w\\)" nil t)
      (replace-match (concat " : " (capitalize (match-string 1)))))
    (goto-char (point-min))
    (while (re-search-forward "\\. \\(\\w\\)\\(\\w+\\)" nil t)
      (replace-match (concat ". " (capitalize (match-string 1)) (match-string 2))))
    (goto-char (point-min))
    (while (re-search-forward "^\\(\\**\\) \\(\\w\\)\\(\\w+\\)" nil t)
      (replace-match (concat (match-string 1) " " (capitalize (match-string 2)) (match-string 3))))
    (goto-char (point-min))
    (while (re-search-forward "! \\(\\w\\)" nil t)
      (replace-match (concat "! " (capitalize (match-string 1)))))
    (goto-char (point-min))
    (while (re-search-forward "\\? \\(\\w\\)" nil t)
      (replace-match (concat "? " (capitalize (match-string 1)))))
    (goto-char (point-min))
    )
  )
;; * Tohtmldoc
(defun ehtmldoc()
  (interactive)
  (setq document (buffer-substring-no-properties (point-max) (point-min)))
  (with-temp-buffer
    (insert document)
    (text-mode)
    (capitales)
    (goto-char (point-min))
    (mapcar (lambda (list)
	      (save-excursion
		(replace-regexp (car list) (cadr list))))
	    '(
	      ("^- \\([0-9:]*\\) :: \\(.*\\)$"	"@@html:<span style=\"font-size:9px\" class=\"btn btn-primary btn-xs\">@@- \\1 ::@@html:</span>@@ *\\2*") ;; questions
	      ("^\\([^:\n ]*\\) : \\(.*\\)$"		"*\\1 :* \\2") ;; reponses identifiées
	      ("^\\([0-9]\\)"				"  \\1") ;; chiffres orphelins en début de lignes (org-mode a tendance à les considérer comme une liste numérotée)
	      ("\\([0-9]\\)e\\>"			"\\1^{e}") ;; 1^{e} en exposant pr l'export html
	      )
	    )
    (org-mode)
    (goto-char (point-min))
    (setq titre-du-document (nth 4 (org-heading-components)))
    (kill-line)
    (goto-char (point-min))
    (insert (concat "#+TITLE:     " titre-du-document "\n"))
    (insert-file-contents "~/org/forhtml.org")
    (org-html-export-as-html)
    (write-file (concat "~/Bureau/" titre-du-document ".html") t)
    (kill-buffer (concat titre-du-document ".html"))
    )
  (progn
    (cd "/home/aziz/Bureau")
    (start-process "mise-en-forme" "*test*"  "lowriter" "--nologo"  (concat titre-du-document ".html")))
  ;; (start-process "mise-en-forme" "*test*"  "lowriter" "--nologo"  (concat "~/Bureau/" titre-du-document ".html"))
  ;; (start-process "mise-en-forme" "*scratch*"  "lowriter" (concat "\"~/Bureau/" titre-du-document ".html\""))
  )

;; * Menufy
(defun menufy()
  (interactive)
  (setq  ossature  (org-map-entries (lambda()
				      (let (fruit)
					(if (looking-at org-complex-heading-regexp)
					    (progn
					      (setq fruit (substring-no-properties (match-string 4)))
					      (setq uid (asciify-text (replace-regexp-in-string " " "_" fruit)))
					      (org-entry-put nil "CUSTOM_ID" uid)
					      (list fruit uid)

					      ))))))
  (with-temp-buffer
    (while ossature
      (setq os (pop ossature))
      (insert (concat "<li><a href=\"#" (nth 1 os) "\">" (nth 0 os) "</a></li>\n")))
    (setq plan (buffer-substring-no-properties (point-min) (point-max))))

  (dd)
  (insert (concat
	   "#+BEGIN_HTML
    <div class=\"container\">
      <div class=\"container bs-docs-container\">
        <div class=\"row\">
          <div class=\"col-md-3\">
              <div class=\"bs-docs-sidebar hidden-print hidden-xs hidden-sm\" role=\"complementary\">
                <ul class=\"nav bs-docs-sidenav\">
"
	   plan

	   "             </ul>
            </div>
          </div>
          <div class=\"col-md-9\" role=\"main\">
#+END_HTML
"))
  (goto-char (point-max))
  (insert "
#+BEGIN_HTML
          </div>
    </div>
</div>
    <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js\"></script>
    <script src=\"../assets/bootstrap-3/js/bootstrap.min.js\"></script>
    <script src=\"../assets/docs.min.js\"></script>
    <!-- <script src=\"../assets/jquery-2.0.2.min.js\"></script>             -->
#+END_HTML
"
	  ))

;; * pdnToHtml
(defun ehtmlhtml()
  (interactive)
  (setq document (buffer-substring-no-properties (point-max) (point-min)))
  (with-temp-buffer
    (insert document)
    (text-mode)
    (capitales)
    (goto-char (point-min))
    (while (re-search-forward "^- \\([0-9:]*\\) :: \\(.*\\)$" nil t)
      (setq seek (substring-no-properties (match-string 1))
	    texte (substring-no-properties (match-string 2))
	    seekS (number-to-string (org-time-string-to-seconds seek))
	    replace (concat "@@html:<span style=\"font-size:9px\" class=\"btn btn-primary btn-xs\" onclick=\"jwplayer().seek(" seekS ");\">@@- " seek " ::@@html:</span>@@ *" texte "*"))
      (beginning-of-line)
      (kill-line)
      (insert replace)
      )

    (goto-char (point-min))
    (replace-regexp "^\\([0-9]\\)" "  \\1")

    (goto-char (point-min))
    (replace-regexp "\\([0-9]\\)e\\>" "\\1^{e}")

    (goto-char (point-min))
    (while (re-search-forward "^\\([^:
 ]*\\) : \\(.*\\)$" nil t)
      (setq seek (substring-no-properties (match-string 1)))
      (setq texte (substring-no-properties (match-string 2)))
      (setq replace (concat "*" seek "* : " texte))
      (beginning-of-line)
      (kill-line)
      (insert replace)
      )

    (org-mode)
    (goto-char (point-min))
    (setq titre-du-document (nth 4 (org-heading-components)))
    (kill-line)
    (menufy)
    (goto-char (point-min))
    (insert "#+SETUPFILE:    ~/public_html/fold/mod-retrans.org\n") ; (insert-file-contents "~/public_html/fold/mod-retrans.org")
    (goto-char (point-min))
    (insert (concat "#+TITLE:     " titre-du-document "\n"))




    (org-html-export-as-html)
    (write-file (concat "~/public_html/fold/" titre-du-document ".html") t)
    (kill-buffer (concat titre-du-document ".html"))
    )

  )
;; * toTable
(defun totable()
  (interactive)
  (save-excursion

    (goto-char (point-min))
    (setq
     n-item 0
     hl-unit ""
     hl-list '()
     titre-list '()
     chapter ""
     seek ""
     text ""
     replace "")

    (while (search-forward-regexp "^\\* " nil t) ;; à chaque premier niveau
      (setq n-item (+ 1 n-item))
      (org-narrow-to-subtree)                     ;; narrow
      (setq chapter (buffer-substring-no-properties (point-min) (point-max)))

      (with-temp-buffer                           ;; insérer dans un temp buffer
	(insert chapter)

	(org-mode)
	(goto-char (point-min))
	(setq hl-unit (nth 4 (org-heading-components)))   ;;
	(setq new-line hl-unit)           ;; name of the hash is a variable content
	(add-to-list 'titre-list new-line)
	(setq new-line (make-hash-table :test 'equal))
	(add-to-list 'hl-list new-line)

	(text-mode)
	(goto-char (point-min))
	(while (re-search-forward "^_- \\([0-9:]*\\) ::_ \\*\\(.*\\)\\*$" nil t)
	  (setq seek (substring-no-properties (match-string 1)))
	  (setq texte (substring-no-properties (match-string 2)))
	  (setq seeks (number-to-string (org-time-string-to-seconds seek)))
	  (setq replace (concat "<span class=\"btn btn-mini\" onclick=\"" hl-unit "_seek(" seeks ")\">- " seek " :: </span><b>" texte "</b><br/>"))
	  (beginning-of-line)
	  (kill-line)
	  (insert replace)
	  )

	(goto-char (point-min))
	(replace-regexp "@@html:"
			"")
	(goto-char (point-min))
	(replace-regexp "@@"
			"")

	(goto-char (point-min))
	(replace-regexp "^\\*\\(.*\\)\\* : \\(.*\\)$"
			"<b>\\1</b> : \\2<br/>")

	(goto-char (point-min))
	(replace-regexp "^$"
			"</p><p>")

	(goto-char (point-min))
	(replace-regexp "^[^*].*[^>]$"
			"\\&<br/>")
	(org-mode)
	(goto-char (point-min))

	(while (search-forward-regexp "^\\*\\* " nil t)
	  (org-narrow-to-subtree)
	  (setq
	   hl-part (nth 4 (org-heading-components))
	   hl-content (buffer-substring-no-properties (line-end-position) (point-max))
	   )
	  (puthash hl-part hl-content new-line)
	  (widen)
	  )
	)
      (widen)
      )
    (setq parties '("Intro" "Souvenir" "Évocation"
                    "Prototype 1" "Prototype 2" "Prototype 3"  "Prototype 4" "Prototype 5"
                    "Classement" "Vision holistique" "C" "R" "Y"))


    (setq momo 0)
;; tete du tableau
    (with-temp-buffer
      (setq nono 0)
      (insert "\n<table class=\"table table-striped table-bordered\" style=\"table-layout:fixed;\">
<col width=\"500\">
<col width=\"500\">
<col width=\"500\">
<col width=\"500\">
<col width=\"500\">
<col width=\"500\">
<col width=\"500\">
<col width=\"500\">
<col width=\"500\">
<tr style=\"\">\n")
      (while (< nono (length hl-list))
	(insert "<td>" (nth nono titre-list) "</td>")
	(setq nono (+ 1 nono))
	)
      (insert "</tr>\n")


;; corps du tableau

      (while (< momo (length parties))
	(setq partie (nth momo parties))

	(insert "<tr  class=\"" (replace-regexp-in-string " " "_" partie)  "_toggler\">")
	(setq nono 0)
	(while (< nono (length hl-list))
	  (insert "<td><div type=\"button\" class=\"btn btn-info\" style=\"\">" partie " " (nth nono titre-list) "</div></td>")
	  (setq nono (+ 1 nono))
	  )

	(insert "</tr>\n
<tr  class=\"" (replace-regexp-in-string " " "_" partie) "\">")
	(setq nono 0)
	(while (< nono (length hl-list))
	  (setq contenu (gethash partie (nth nono hl-list)))
	  (insert "\n<td class=\"" (nth nono titre-list) "\">" contenu "</td>")
	  (setq nono (+ 1 nono))
	  )
	(setq momo (+ 1 momo))
	(insert "</tr>")
	)
      (insert "</table>\n")
      (append-to-buffer "ensemble.html" (point-min) (point-max))

      )

;; javascript
    ;; (setq momo 0)
    ;; (with-temp-buffer
    ;;   (while (< momo (length parties))
    ;; 	(setq partie (nth momo parties))
    ;; 	(insert " $('." (replace-regexp-in-string " " "_" partie) "_toggler ').click(function(){$('." (replace-regexp-in-string " " "_" partie) "').slideToggle();});\n")
    ;; 	(setq momo (+ 1 momo))
    ;; 	)
    ;;   (append-to-buffer "ensemble.html" (point-min) (point-max))
    ;;   )


    ))



;; * publish
(setq org-publish-project-alist
      '(
        ("miseaplat"
         :base-directory "~/camembert-algerie/publish/"
         :base-extention "org"
         :publishing-directory "~/public_html/miseaplat"
         :recursive t
         :publishing-function org-html-publish-to-html
	 )
        ("pieces"
         :base-directory "~/camembert-algerie/publish/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|html\\|php\\|pdf\\|mp4"
         :publishing-directory "~/public_html/miseaplat"
         :recursive t
         :publishing-function org-publish-attachment)
        ("a" :components ("miseaplat" "pieces"))
        ))

;; * publish
(setq org-publish-project-alist
      '(
        ("memoire"
         :base-directory "~/org/publish/"
         :base-extention "org"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-html-publish-to-html
	 )
        ("pieces"
         :base-directory "~/org/publish/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|html\\|php\\|pdf\\|mp4"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-publish-attachment)
        ("a" :components ("memoire" "pieces"))
        ))
;; * toTable
(defun totable()
  (interactive)
  (save-excursion

    (goto-char (point-min))
    (setq
     n-item 0
     hl-unit ""
     hl-list '()
     titre-list '()
     chapter ""
     seek ""
     text ""
     replace "")

    (while (search-forward-regexp "^\\* " nil t) ;; à chaque premier niveau
      (setq n-item (+ 1 n-item))
      (org-narrow-to-subtree)                     ;; narrow
      (setq chapter (buffer-substring-no-properties (point-min) (point-max)))

      (with-temp-buffer                           ;; insérer dans un temp buffer
	(insert chapter)

	(org-mode)
	(goto-char (point-min))
	(setq hl-unit (nth 4 (org-heading-components)))   ;;
	(setq new-line hl-unit)           ;; name of the hash is a variable content
	(add-to-list 'titre-list new-line)
	(setq new-line (make-hash-table :test 'equal))
	(add-to-list 'hl-list new-line)

	(text-mode)
	(goto-char (point-min))
	(while (re-search-forward "^_- \\([0-9:]*\\) ::_ \\*\\(.*\\)\\*$" nil t)
	  (setq seek (substring-no-properties (match-string 1)))
	  (setq texte (substring-no-properties (match-string 2)))
	  (setq seeks (number-to-string (org-time-string-to-seconds seek)))
	  (setq replace (concat "<span class=\"btn btn-mini\" onclick=\"" hl-unit "_seek(" seeks ")\">- " seek " :: </span><b>" texte "</b><br/>"))
	  (beginning-of-line)
	  (kill-line)
	  (insert replace)
	  )

	(goto-char (point-min))
	(replace-regexp "@@html:"
			"")
	(goto-char (point-min))
	(replace-regexp "@@"
			"")

	(goto-char (point-min))
	(replace-regexp "^\\*\\(.*\\)\\* : \\(.*\\)$"
			"<b>\\1</b> : \\2<br/>")

	(goto-char (point-min))
	(replace-regexp "^$"
			"</p><p>")

	(goto-char (point-min))
	(replace-regexp "^[^*].*[^>]$"
			"\\&<br/>")
	(org-mode)
	(goto-char (point-min))

	(while (search-forward-regexp "^\\*\\* " nil t)
	  (org-narrow-to-subtree)
	  (setq
	   hl-part (nth 4 (org-heading-components))
	   hl-content (buffer-substring-no-properties (line-end-position) (point-max))
	   )
	  (puthash hl-part hl-content new-line)
	  (widen)
	  )
	)
      (widen)
      )
    (setq parties '("Intro" "Souvenir" "Évocation"
                    "Prototype 1" "Prototype 2" "Prototype 3"  "Prototype 4" "Prototype 5"
                    "Classement" "Vision holistique" "C" "R" "Y"))


    (setq momo 0)
    (with-temp-buffer
      (setq nono 0)
      (insert "\n<div class=\"row\">")
      (while (< nono (length hl-list))
	(insert "<div class=\"col-xs-1\" style=\"position:fixed;top:20px;\">" (nth nono titre-list) "</div>")
	(setq nono (+ 1 nono))
	)
      (insert "</div>\n")

      (while (< momo (length parties))
	(setq partie (nth momo parties))
	(setq nono 0)
	(insert "<div  class=\"row " (replace-regexp-in-string " " "_" partie)  "_toggler\">
<div class=\"btn btn-alerte\" style=\"\">" partie "</div></div>")
	(insert "<div  class=\"row " (replace-regexp-in-string " " "_" partie) "\">")
	(while (< nono (length hl-list))
	  (setq contenu (gethash partie (nth nono hl-list)))
	  (insert "\n<div class=\"col-xs-1 " (nth nono titre-list) "\">" contenu "</div>")
	  (setq nono (+ 1 nono))
	  )
	(setq momo (+ 1 momo))
	(insert "</div>\n")
	)
      (append-to-buffer "ensemble.html" (point-min) (point-max))

      )

    (setq momo 0)
    (with-temp-buffer
      (while (< momo (length parties))
	(setq partie (nth momo parties))
	(insert " $('." (replace-regexp-in-string " " "_" partie) "_toggler ').click(function(){$('." (replace-regexp-in-string " " "_" partie) "').slideToggle();});\n")
	(setq momo (+ 1 momo))
	)
      (append-to-buffer "ensemble.html" (point-min) (point-max))
      )


    ))
;; * camembertToTable
(defun totable()
  (interactive)
  (save-excursion

    (goto-char (point-min))

    (setq
     n-item 0
     hl-unit ""
     hl-list '()
     titre-list '()
     chapter ""
     seek ""
     text ""
     replace "")

    (while (search-forward-regexp "^\\* " nil t) ;; à chaque premier niveau
      (setq n-item (+ 1 n-item))
      (org-narrow-to-subtree)                     ;; narrow
      (setq chapter (buffer-substring-no-properties (point-min) (point-max)))

      (with-temp-buffer                           ;; insérer dans un temp buffer
	(insert chapter)
;;;;; make hash
	(org-mode)
	(goto-char (point-min))
	(setq hl-unit (nth 4 (org-heading-components)))   ;;
	(setq new-line hl-unit)           ;; name of the hash is a variable content
	(add-to-list 'titre-list new-line)
	(setq new-line (make-hash-table :test 'equal))
	(add-to-list 'hl-list new-line) ;; créer une list de noms for hashs

	(text-mode)
	(goto-char (point-min))
	(while (re-search-forward "^_- \\([0-9:]*\\) ::_ \\*\\(.*\\)\\*$" nil t)
	  (setq seek (substring-no-properties (match-string 1)))
	  (setq texte (substring-no-properties (match-string 2)))
	  (setq seeks (number-to-string (org-time-string-to-seconds seek)))
	  (setq replace (concat "<span class=\"btn btn-mini\" onclick=\"" hl-unit "_seek(" seeks ")\">- " seek " :: </span><b>" texte "</b><br/>"))
	  (beginning-of-line)
	  (kill-line)
	  (insert replace)
	  )

	;; (goto-char (point-min))
	;; (replace-regexp "@@html:"
	;; 		"")
	;; (goto-char (point-min))
	;; (replace-regexp "@@"
	;; 		"")

	(goto-char (point-min))
	(replace-regexp "^\\*\\(.*\\)\\* : \\(.*\\)$"
			"<b>\\1</b> : \\2<br/>")

	(goto-char (point-min))
	(replace-regexp "^$"
			"</p><p>")

	(goto-char (point-min))
	(replace-regexp "^[^*].*[^>]$"
			"\\&<br/>")
	(org-mode)
	(goto-char (point-min))

;;;; put hash
	(while (search-forward-regexp "^\\*\\* " nil t)
	  (org-narrow-to-subtree)
	  (setq
	   hl-part (nth 4 (org-heading-components))
	   hl-content (buffer-substring-no-properties (line-end-position) (point-max))
	   )
	  (puthash hl-part hl-content new-line)
	  (widen)
	  )
	)
      (widen)
      )
    (setq parties '("Intro" "Souvenir" "Évocation"
                    "Prototype 1" "Prototype 2" "Prototype 3"  "Prototype 4" "Prototype 5"
                    "Classement" "Vision holistique" "C" "R" "Y"))


    (setq momo 0)
    (with-temp-buffer
      (setq nono 0)
      (insert "\n<div class=\"row\">")
      (while (< nono (length hl-list))
	(insert "<div class=\"col-xs-1\" style=\"position:fixed;top:20px;\">" (nth nono titre-list) "</div>")
	(setq nono (+ 1 nono))
	)
      (insert "</div>\n")

      (while (< momo (length parties))
	(setq partie (nth momo parties))
	(setq nono 0)
	(insert "<div  class=\"row " (replace-regexp-in-string " " "_" partie)  "_toggler\">
<div class=\"btn btn-alerte\" style=\"\">" partie "</div></div>")
	(insert "<div  class=\"row " (replace-regexp-in-string " " "_" partie) "\">")
	(while (< nono (length hl-list))
	  (setq contenu (gethash partie (nth nono hl-list)))
	  (insert "\n<div class=\"col-xs-1 " (nth nono titre-list) "\">" contenu "</div>")
	  (setq nono (+ 1 nono))
	  )
	(setq momo (+ 1 momo))
	(insert "</div>\n")
	)
      (append-to-buffer "ensemble.html" (point-min) (point-max))

      )

    (setq momo 0)
    (with-temp-buffer
      (while (< momo (length parties))
	(setq partie (nth momo parties))
	(insert " $('." (replace-regexp-in-string " " "_" partie) "_toggler ').click(function(){$('." (replace-regexp-in-string " " "_" partie) "').slideToggle();});\n")
	(setq momo (+ 1 momo))
	)
      (append-to-buffer "ensemble.html" (point-min) (point-max))
      )


    ))
;; * veolia
(defun veolia()
  (interactive)
  (setq document (buffer-substring-no-properties (point-max) (point-min)))
  (with-temp-buffer
    (insert document)
    (text-mode)
;    (capitales)
    (goto-char (point-min))
    (mapcar (lambda (list)
	      (save-excursion
		(replace-regexp (car list) (cadr list))))
	    '(
	      ("^- \\([0-9:]*\\) :: dd \\(.*\\)$"	"@@html:<span style=\"font-size:10px;background:#000099;color:white;\">@@- \\1 ::@@html:</span>@@ *\\2*") ;; client
	      ("^- \\([0-9:]*\\) :: pp \\(.*\\)$"	"@@html:<span style=\"font-size:10px;background:#D80000;color:white;\">@@- \\1 ::@@html:</span>@@ *\\2*") ;; opé
	      ("^\\([^:\n ]*\\) : \\(.*\\)$"		"*\\1 :* \\2") ;; reponses identifiées
	      ("^\\([0-9]\\)"				"  \\1") ;; chiffres orphelins en début de lignes (org-mode a tendance à les considérer comme une liste numérotée)
	      ("\\([0-9]\\)e\\>"			"\\1^{e}") ;; 1^{e} en exposant pr l'export html
	      )
	    )
    (capitales)
    (goto-char (point-min))
    (while (re-search-forward "@@ \\*\\(\\w\\)" nil t)
      (replace-match (concat "@@ *" (capitalize (match-string 1)))))
    (org-mode)
    (goto-char (point-min))
    (setq titre-du-document (nth 4 (org-heading-components)))
    (kill-line)
    (goto-char (point-min))
    (insert (concat "#+TITLE:     " titre-du-document "\n"))
    (insert-file-contents "~/org/forhtml.org")
    (org-html-export-as-html)
    (write-file (concat "~/Bureau/" titre-du-document ".html") t)
    (kill-buffer (concat titre-du-document ".html"))
    )
  (progn
     (cd "/home/aziz/Bureau")
     (start-process "mise-en-forme" "*test*"  "lowriter" "--nologo"  (concat titre-du-document ".html")))
  ;; (start-process "mise-en-forme" "*test*"  "lowriter" "--nologo"  (concat "~/Bureau/" titre-du-document ".html"))
  ;; (start-process "mise-en-forme" "*scratch*"  "lowriter" (concat "\"~/Bureau/" titre-du-document ".html\""))

  )

;; * veoliacor
(defun veoliacorrection()
  "Replace “<” to “&lt;” and some other chars in HTML.
This works on the current region."
  (interactive)
  (condition-case nil (backup-this-file) (error nil))
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
	    ;; ("@" "~")
	    ;; ("&&" "~")
	    ("&" "\n")
;	    ("~" "&")
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
	    ("\\([^?!.]\\)$" "\\1.")
	    )
	  )

					;nommage
  ;; (mapcar (lambda(x)
  ;; 	    (save-excursion
  ;; 	      (re-search-forward x nil t)
  ;; 	      (setq z (progn (re-search-forward "\\(\\w+\\)") (match-string 1)))
  ;; 	      (dd) (replace-regexp x (concat z " : ")))
  ;; 	    )
  ;; 	  '("^& " "^é " "^\" " "^' " "^( " "^- " "^è " "^_ "))
					;saut de ligne final
  ;; (save-excursion (replace-regexp "+ \\(.*\\)" "\n- \\1 ?"))
  ;;(save-excursion (replace-regexp "+ \\(.*[^?]\\)" "\n- \\1."))
  (save-buffer)

  (visual-line-mode)
  (flyspell-mode)
  (flyspell-buffer)
  (local-set-key	"œ"		'flyspell-goto-next-error)
  (local-set-key	"\C-z"		'transpose-chars)
  )
;; * slek
(defun slek()
(interactive)
    (capitales)
    (goto-char (point-min))
    (mapcar (lambda (list)
	      (save-excursion
		(replace-regexp (car list) (cadr list))))
	    '(
	      ("^- \\([0-9:]*\\) :: \\(.*\\)$"	"@@html:<span style=\"font-size:9px\" class=\"btn btn-primary btn-xs\">@@- \\1 ::@@html:</span>@@ *\\2*") ;; questions
	      ("^\\([^:\n ]*\\) : \\(.*\\)$"		"*\\1 :* \\2") ;; reponses identifiées
	      ("^\\([0-9]\\)"				"  \\1") ;; chiffres orphelins en début de lignes (org-mode a tendance à les considérer comme une liste numérotée)
	      ("\\([0-9]\\)e\\>"			"\\1^{e}") ;; 1^{e} en exposant pr l'export html
	      )
	    )
    (goto-char (point-min))
    (setq titre-du-document (nth 4 (org-heading-components)))
    (kill-line)
    (goto-char (point-min))
    (insert (concat "#+TITLE:     " titre-du-document "\n"))
    (insert-file-contents "~/org/forhtml.org")
)
