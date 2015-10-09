;; * etudeSnap
(defun position-to-kill-ring ()
  "Copy to the kill ring a string in the format \"file-name:line-number\"
for the current buffer's file name, and the line number at point."
  (interactive)
  (save-excursion
    (outline-previous-visible-heading 1)
    (setq partie (nth 4 (org-heading-components)))   ;;
    (outline-up-heading 1)
    (setq reunion (nth 4 (org-heading-components)))   ;;
    )

  (save-excursion
    (if    (re-search-backward "^_- \\([0-9:]*\\) ::_ " nil t)
	(setq pos (substring-no-properties (match-string 1)))
      (setq pos "Temps"))
    )

  (save-excursion
    (beginning-of-line)
    (if    (re-search-forward "^\\*\\(.*\\)\\* : " (+ 10 (point)) t)
	(setq nom (substring-no-properties (match-string 1)))
      (setq nom "Nom")))

  (save-excursion
    (beginning-of-line)
    (setq line    (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
  (setq org-refile-use-cache nil)
  (setq org-refile-targets (quote (("/home/azyvers/org/ateliers/04-2014/SNAP/verbatims.org" :tag . "collection"))))
  (setq extrait  (format "- [[%s::%d][%s %s (%s)]] :: %s" (buffer-file-name) (save-restriction (widen) (line-number-at-pos)) reunion (replace-regexp-in-string " " "_" partie) pos line))
  (with-temp-buffer
    (insert extrait)
    (org-mode)
    (mark-whole-buffer)
    (org-refile))

  ;; (kill-new
  ;;  (format "- [[%s::%d][%s %s (%s)]] :: *%s* : %s" (buffer-file-name) (save-restriction (widen) (line-number-at-pos)) reunion (replace-regexp-in-string " " "_" partie) pos nom line))

  )

;; * etudeCamAlgérie
(defun map-this-region (start end)
  "Copy to the kill ring a string in the format \"file-name:line-number\"
for the current buffer's file name, and the line number at point."
  (interactive "r")
  (setq
   org-refile-targets (quote (("/home/aziz/camembert-algerie/pdns/image_et_classement.org" :maxlevel . 3)))
   org-refile-use-cache nil
   line (buffer-substring-no-properties start end)
   nom (save-excursion
	 (end-of-line)
	 (if    (re-search-backward "^\\*\\(.*\\)\\* : " nil t)
	     (substring-no-properties (match-string 1))
	   "Nom"))
   type (parent)
   reunion (ancestor)
   extrait  (format "[[%s::%d][%s %s %s]] %s"
		    (buffer-file-name)
		    (save-restriction (widen) (line-number-at-pos))
		    reunion
		    nom
		    type
		    ;; (replace-regexp-in-string " " "_" partie)
		    ;; pos
		    line))
  (with-temp-buffer
    (insert extrait)
    (org-mode)
    (mark-whole-buffer)
    (org-refile)))
;; * map-this-region

  ;; (save-excursion
  ;;   (outline-previous-visible-heading 1)
  ;;   (setq partie (nth 4 (org-heading-components)))   ;;
  ;;   (setq type partie) ;(substring partie 30))
  ;;   (outline-up-heading 1)
  ;;   (setq reunion (nth 4 (org-heading-components)))   ;;
  ;;   )


  ;; (save-excursion
  ;;   (if    (re-search-backward "^_- \\([0-9:]*\\) ::_ " nil t)
  ;; 	(setq pos (substring-no-properties (match-string 1)))
  ;;     (setq pos "Temps"))
  ;;   )

  ;; (save-excursion
  ;;   (beginning-of-line)
  ;;   (setq line    (buffer-substring-no-properties (line-beginning-position) (line-end-position))))

  ;; (setq org-refile-use-cache nil)
  ;;   (setq org-refile-targets (quote (("/home/aziz/camembert-algerie/pdns/image_et_classement.org" :maxlevel . 3))))


  ;;   (setq extrait  (format "[[%s::%d][%s %s %s]] %s"
  ;; 			 (buffer-file-name)
  ;; 			 (save-restriction (widen) (line-number-at-pos))
  ;; 			 reunion
  ;; 			 nom
  ;; 			 type
  ;; ;			 (replace-regexp-in-string " " "_" partie)
  ;; ;;			 pos
  ;; 			 line))
  ;;   (with-temp-buffer
  ;;     (insert extrait)
  ;;     (org-mode)
  ;;     (mark-whole-buffer)
  ;;     (org-refile))

  ;; (kill-new
  ;;  (format "- [[%s::%d][%s %s (%s)]] :: *%s* : %s" (buffer-file-name) (save-restriction (widen) (line-number-at-pos)) reunion (replace-regexp-in-string " " "_" partie) pos nom line))

  ;;  )
