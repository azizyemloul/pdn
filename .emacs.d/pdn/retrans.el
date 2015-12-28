;; * Keys
(define-key org-mode-map	"\C-cy"			'mplayer-master)
(define-key mplayer-mode-map	(kbd "=")		'mplayer-inteligent-insert-timestamp)
(define-key mplayer-mode-map	(kbd "$")		'mplayer-inteligent-seek-backward)
(define-key mplayer-mode-map	(kbd "]")		'mplayer-inteligent-seek-forward)
(define-key mplayer-mode-map	(kbd "}")		'mplayer-inteligent-pause)
;; * mplayerMaster
(defun mplayer-master()
  (interactive)
  (goto-char (point-min))
  (if (eq (re-search-forward "^- [0-9]\\{0,2\\}:\\{0,1\\}[0-9]\\{0,2\\}:\\{0,1\\}[0-9]\\{1,2\\} ::" nil t) 'nil)
      (call-interactively 'mplayer-go-ahead nil)

    (progn
      (goto-char (point-min))
      (mplayer-inteligent-resume)

      )))
;; * mplayerGoAhead
(defun  mplayer-go-ahead(audio)
  (interactive "FFichier Audio à lire: ")
  (goto-char (point-max))
  (insert "* " (file-name-sans-extension (file-name-nondirectory audio)))
  (org-entry-put nil "MEDIAS" (file-name-nondirectory audio))
  (org-entry-put nil "CHEMIN" (file-name-directory (expand-file-name audio)))
  (mplayer-mode 1)
  (mplayer-find-file (expand-file-name audio))
  ;;(mplayer-insert-timelenght)
  (goto-char (point-max))
  (insert "\n** Intro\n")
  (org-clock-in)
  (goto-char (point-max))
;  (sleep-for 1.9)
;  (call-process "jack_connect" nil "*scratch*" nil "myplayer:out_0" "ffmpeg:input_1")
;  (call-process "jack_connect" nil "*scratch*" nil "myplayer:out_1" "ffmpeg:input_2")
  )
;; * mplayerResume
(defun mplayer-resume()
  (mplayer-mode 1)
  (setq
   audio-file (concat (org-entry-get nil "CHEMIN") (org-entry-get nil "MEDIAS"))
   this-buffer (buffer-name))
  (mplayer-find-file audio-file)
  (switch-to-buffer-other-window mplayer-process-buffer)
  (switch-to-buffer-other-window this-buffer)
  (goto-char (point-max))
  (search-backward-regexp "^- \\([0-9]\\{0,2\\}:\\{0,1\\}[0-9]\\{0,2\\}:\\{0,1\\}[0-9]\\{1,2\\}\\) ::")
  (aziz-mplayer-seek-position-at-point)
  (setq status "playing"))
;; * mplayerInsertLenght
(defun mplayer-insert-lenght ()
  "Insert a time-stamp of the current recording position in the
buffer.  See `mplayer-timestamp-format' for the insertion
format."
  (interactive)
  (let (time)
    (set-process-filter
     mplayer-process
     ;; wait for output, process, and remove filter:
     (lambda (process output)
       (message "process: %s output: %s" process output)
       (string-match "^ANS_LENGTH=\\(.*\\)$" output)
       (setq time (match-string 1 output))
       (if time
	   (org-entry-put nil "Effort" (aziz--format-time time))
	 ;; (org-entry-put nil "DUREE" (file-name-nondirectory audio))
	 ;;     (insert (aziz--format-time time))
	 (message "MPlayer: couldn't detect current time."))
       (set-process-filter mplayer-process nil)))
    ;; Then send the command:
    (mplayer--send "get_time_length")))
;; * mplayerIntelligentResume
(defun mplayer-inteligent-resume()
  (interactive)
  (if (eq (org-clocking-p) 'nil)
      (progn (mplayer-resume) (org-clock-in))
    (progn (mplayer-resume) (message "Attention"))))
;; * mplayerIntelligentInsertTimestamp
(defun mplayer-inteligent-insert-timestamp()
  (interactive)
  (if (eq (org-clocking-p) 'nil)
      (progn (org-clock-in) (goto-char (point-max)) (mplayer-insert-timestamp))
    (mplayer-insert-timestamp)))
;; * azizMplayerSeekPositionAtPoint
(defun aziz-mplayer-seek-position-at-point()
  "Commentaire"
  (interactive)
  (search-forward-regexp "^- \\([0-9]\\{0,2\\}:\\{0,1\\}[0-9]\\{0,2\\}:\\{0,1\\}[0-9]\\{1,2\\}\\) ::")
  (mplayer-seek-position (org-time-string-to-seconds (match-string 1))))
(define-key mplayer-mode-map (kbd "\\") 'aziz-mplayer-seek-position-at-point)

;; * azizTimestampFormat
(defvar aziz-timestamp-format "%H:%M:%S"
  "Format used for inserting timestamps.")

;; * azizTimerItem
(defun aziz-timer-item (&optional arg)
  "Insert a description-type item with the current timer value."
  (interactive "P")
  (let ((ind 0))
    (save-excursion
      (skip-chars-backward " \n\t")
      (condition-case nil
	  (progn
	    (org-beginning-of-item)
	    (setq ind (org-get-indentation)))
	(error nil)))
    (or (bolp) (newline))
    (org-indent-line-to ind)
    (insert "- ")
    (org-timer (if arg '(4)))
    (insert ":: ")))
;; * Traff
(defun traff()
  "Transforme les fichiers audio dans le répertoire courant en titres"
  (interactive)
  ;; org-map-entries calls org-prepare-agenda-buffers like this:

  ;; (org-prepare-agenda-buffers
  ;;  (list (buffer-file-name (current-buffer))))

  ;; In turn, this calls org-check-agenda-file() and if the current buffer
  ;; has not been written out yet, this pops the question.

  ;; https://lists.gnu.org/archive/html/emacs-orgmode/2012-06/msg00123.html
  (insert " ")
  (delete-backward-char)
  (save-buffer)
  (let
      (
      					; mettre les fichiers audios dans le répertoire courant dans une liste nommée nouveaux-fichiers
       (nouveaux-fichiers (directory-files "." t "\\(wma\\|mp3\\|wav\\|WMA\\|MP3\\|WAV\\|flv\\|ogg\\|avi\\|wmv\\)$")) ;
      					; mettre les médias déjà consignés dans le fichier courant dans une liste nommée fichiers-enregistrés
       (fichiers-enregistrés  (org-map-entries
      			       (lambda ()
      				 (let (exist)
      				   (setq exist (org-entry-get nil "MEDIAS"))))))
       )

					; pour chaque nouveau fichier
    (while nouveaux-fichiers
      (setq chemin-et-nom  (pop nouveaux-fichiers)
	    nom-de-fichier (file-name-nondirectory chemin-et-nom))
      (if (not (member nom-de-fichier fichiers-enregistrés))
	  (let(
	       (chemin-complet (file-name-directory chemin-et-nom))
	       (nouveau-titre  (file-name-sans-extension nom-de-fichier))
	       (date-reception (format-time-string "%a %d-%m-%y %H:%M" (nth 5 (file-attributes nom-de-fichier))))
	       )
					; vérifier que seuls les nouveaux fichiers seront traités
	    (insert (concat "* " nouveau-titre "\n"))
	    (org-todo)
	    (org-entry-put nil "ORIGIN" nouveau-titre)
	    (org-entry-put nil "CHEMIN" "./")
	    (org-entry-put nil "MEDIAS" nom-de-fichier)
	    (org-entry-put nil "REÇULE" date-reception)
	    (org-entry-put nil "Effort"
			   (let (
				 (infos (shell-command-to-string (concat "ffprobe \"" chemin-et-nom "\"")))
				 )
			     (string-match "Duration: \\([^,]*\\)" infos)
			 (match-string 1 infos)))
	    (insert "\n** Intro\n- 00:00:01 ::\n")
	    ))
	(message "%s existe déjà" nom-de-fichier))
      )
    )
;; * orgTimeStringToSeconds
(defun org-time-string-to-seconds (s)
  "Convert a string HH:MM:SS to a number of seconds."
  (cond
   ((and (stringp s)
	 (string-match "\\([0-9]+\\):\\([0-9]+\\):\\([0-9]+\\)" s))
    (let (
	  (hour (string-to-number (match-string 1 s)))
	  (min (string-to-number (match-string 2 s)))
	  (sec (string-to-number (match-string 3 s))))
      (+ (* hour 3600) (* min 60) sec)))
   ((and (stringp s)
	 (string-match "\\([0-9]+\\):\\([0-9]+\\)" s))
    (let (
	  (min (string-to-number (match-string 1 s)))
	  (sec (string-to-number (match-string 2 s))))
      (+ (* min 60) sec)))
   ((stringp s) (string-to-number s))
   (t s)))
;; * orgTimeSecondsToString
(defun org-time-seconds-to-string (secs)
  "Convert a number of seconds to a time string."
  (format-seconds "%.2h:%.2m:%.2s" secs))
  ;; (cond ((>= secs 3600) (format-seconds "%.2h:%.2m:%.2s" secs))
  ;; 	((>= secs 60) (format-seconds "%.2h:%.2m:%.2s" secs))
  ;; 	(t (format-seconds "%.2h:%.2m:%.2s" secs))))
;; * azizFormatTime
(defun aziz--format-time (time)
  "Return a formatted time string, using the format string
`mplayer-timestamp-format'.  The argument is in seconds, and
can be an integer or a string."
  (message "format-time: %s" time)
  (if (stringp time)
      (setq time (round (string-to-number time))))
  (message "time to format: %s" time)
  (format-time-string aziz-timestamp-format `(0 ,time 0) t))
;; * defvarMplayerTimestampFormat
(defvar mplayer-timestamp-format "\n- %H:%M:%S :: " "Format used for inserting timestamps.")
;; * traff réécriture
(defun trafff()
  "Préparer un document pour mplayer-mode."
  (interactive)
  (setq
   current-b (current-buffer)
   fichiers-audio (directory-files "." t "\\(wma\\|mp3\\|wav\\|WMA\\|MP3\\|WAV\\|flv\\|ogg\\|avi\\|wmv\\|mp4\\)$")
   fichiers-audio-déjà-répertoriés (org-map-entries
				    (lambda ()
				      (let (exist)
					(setq exist (org-entry-get nil "MEDIAS")))))
   )
  ;; pour chaque nouveau fichier
  (while fichiers-audio
    (setq a  (pop fichiers-audio)
	  a-nu (file-name-nondirectory a))
    (if (eq (member a-nu fichiers-audio-déjà-répertoriés) nil)
	(progn
	  (insert (concat "* " (file-name-sans-extension a-nu) "\n"))
	  ;; on travaille sur la sortie de exiftool
	  (with-temp-buffer
	    (setq informations (substring (shell-command-to-string (concat "exiftool '" a "'")) 0 -1))
	    (insert informations)
	    (goto-char (point-min))
	    (search-forward-regexp "Duration  *: " nil t)
	    (setq effort (buffer-substring-no-properties (point) (pointendofline)))
	    (if (string-match "^\\([0-9][0-9]:[0-9][0-9]\\)$" effort)
			(setq effort (hmgn effort)))
	    (if (string-match "(approx)" effort)
			(setq effort (replace-match "" nil nil effort))))
	  ;; on insère les orgmode PROPERTIES
;	  (with-current-buffer current-b
	    (org-entry-put nil "Effort" effort)
	    (org-entry-put nil "MEDIAS" a-nu)
	    (org-entry-put nil "CHEMAIN" "./")
	    (insert "\n** Intro\n- 00:00:01 ::\n\n")
;	    )
	  )
      (message "%s existe déjà" a-nu))
    ))

(defun pointendofline()
  (end-of-line)
  (point))
