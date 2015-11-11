;; * Facturation à vide
(defun facv()
  (interactive)
  (setq
   client		(if (looking-at org-complex-heading-regexp) (setq leff (substring (substring-no-properties (match-string 5)) 1 -1)))
   facture_n		(org-entry-get nil "facture_n")
   pu_m2_text		(or (org-entry-get nil "TARIF") "45")
   periode		(org-entry-get nil "periode")
   m1			(or (org-entry-get nil "m1") "Retranscription")
   facture_date		(or (org-entry-get nil "emic") (format-time-string "%d-%m-%Y"))

   temps_retrans_s	(apply '+ ;;; faire la somme des secondes ENTIER
			       (mapcar
				(lambda (x) ;;; convertir les Efforts récoltés ci-dessous en secondes ou en 0 si aucun LIST
				  (if (string= x "nil") (setq x 0))
				  (org-time-string-to-seconds x)
				  )
				(org-map-entries ;;; Rassembler tous les Efforts LIST
				 (lambda()
				   (let(z) (setq z (org-entry-get nil "Effort")))))
				)
			       )

   temps_retrans_string (org-time-seconds-to-string temps_retrans_s)

   m2		(if (looking-at org-complex-heading-regexp)
		    (setq w (substring-no-properties (match-string 4))))

   quantite_m2_integer1 (/ temps_retrans_s 3600.00)
   quantite_m2_text (format "%.1f" quantite_m2_integer1)
   quantite_m2_integer (string-to-number quantite_m2_text)

   pu_m2_integer	(string-to-number pu_m2_text)

   montant_m2_integer	(*  pu_m2_integer quantite_m2_integer)
   montant_m2_text	(format "%.2f" montant_m2_integer)


   montant_ht		montant_m2_text
   tva			(format "%.2f" (* montant_m2_integer 0.2))
   total_ttc		(format "%.2f" (* montant_m2_integer 1.2))
   frais_ttc		""
   montant_total	total_ttc
   )
  (org-entry-put nil "HT" montant_ht)
  (org-entry-put nil "TVA" tva)
  (org-entry-put nil "TotalTTC" total_ttc)
  )
;; * Facturation
(defun fac()
  "Remplir le formulaire PDF de la facture à partir des informations sur la mission"
  (interactive)
;; ** cacluls
  (facv)
;; ** client
  (progn
    (find-file "~/org/clients.org")
    (widen)
    (goto-char (point-min))
    (search-forward client)
    (org-narrow-to-subtree)
    (setq
     client_nom			(org-entry-get nil "client_nom")
     client_adress		(org-entry-get nil "client_adress")
     client_ville		(org-entry-get nil "client_ville")
     client_pays		(org-entry-get nil "client_pays")
     client_info_comp		(org-entry-get nil "client_info_comp")
     client_interlocuteur	(org-entry-get nil "client_interlocuteur")
     )
    (kill-buffer)
    )


;; ** systeme de fichier
  (setq
   base (expand-file-name "~/org/RMS/")
   destination (concat base (format-time-string "%m-%Y") "/")
   )
  (if (not (file-exists-p destination))
      (make-directory destination))
;; ** formulaire

  (with-temp-buffer
    (insert
     "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n
<xfdf xmlns=\"http://nous.adobe.com/xfdf/\" xml:space=\"default\">\n
<fields>\n")
    (setq
     recordon	"<field name=\""
     valueon	"\"><value>"
     recordoff	"</value></field>"
     )
    (insert
     (concat	recordon	"client_nom"		valueon		client_nom		recordoff "\n")
     (concat 	recordon	"client_adress"	 	valueon		client_adress	     	recordoff "\n")
     (concat 	recordon	"client_ville"	 	valueon		client_ville	     	recordoff "\n")
     (concat 	recordon	"client_pays"	 	valueon		client_pays	     	recordoff "\n")
     (concat 	recordon	"client_info_comp"	valueon 	client_info_comp   	recordoff "\n")
     (concat 	recordon	"client_interlocuteur"  valueon		client_interlocuteur	recordoff "\n")
     (concat 	recordon	"facture_n"		valueon		facture_n		recordoff "\n")
     (concat 	recordon	"facture_date" 		valueon		facture_date 	     	recordoff "\n")
     (concat 	recordon	"m1"	     		valueon		m1	     	     	recordoff "\n")
     (concat 	recordon	"quantite_m2"  		valueon		quantite_m2_text     	recordoff "\n")
     (concat 	recordon	"m2"	     		valueon		m2	     	     	recordoff "\n")
     (concat 	recordon	"pu_m2"	     		valueon		pu_m2_text     	     	recordoff "\n")
     (concat 	recordon	"montant_m2"   		valueon		montant_m2_text	     	recordoff "\n")
     (concat 	recordon	"periode"		valueon		periode	     		recordoff "\n")
     (concat 	recordon	"montant_ht"		valueon		montant_ht	     	recordoff "\n")
     (concat 	recordon	"tva"	  		valueon		tva	  	     	recordoff "\n")
     (concat 	recordon	"total_ttc" 		valueon		total_ttc 	     	recordoff "\n")
     (concat 	recordon	"frais_ttc" 		valueon		frais_ttc 	     	recordoff "\n")
     (concat 	recordon	"montant_total" 	valueon		montant_total      	recordoff "\n")
;     (concat 	recordon	"type_paiement" 	valueon		type_paiement      	recordoff "\n")
;     (concat 	recordon	"type_reglement"     	valueon		type_reglement		recordoff "\n")
     )

    (insert "</fields></xfdf>")
    (setq
     xfdfdoc (expand-file-name (concat destination "RMS_" client_nom "_" facture_n ".xfdf"))
     xfdflink (concat "RMS_" client_nom "_" facture_n ".xfdf")
     pdf (expand-file-name (concat destination "RMS_" client_nom "_" facture_n ".pdf"))
     )
    (append-to-file (point-min) (point-max) xfdfdoc)
    )

;; ** infos diary
  (org-entry-put nil "Facture" (concat "[[file://" xfdfdoc "][" xfdflink "]]"))
;; ** remplissage de la facture et affichage
  (call-process "pdftk" nil "*scratch*" nil (expand-file-name "~/RMS/facture_fin.pdf") "fill_form" xfdfdoc "output" pdf "flatten")
  (start-process "my-process2" "*scratch*"  "evince" pdf)
  )
;; * BDC
(defun bdc()
  (interactive)
  ;;***********************************************;;
;; ** Fixe Effort For All Items In Narrowed Region ;;
  ;;***********************************************;;
  (save-excursion
    (goto-char (point-min))
    (parse-effort-all)
    )										;; comptabilisation du temps
  ;;***********************************************;;
;; ** collecte et intialisation des valeurs       ;;;
  ;;***********************************************;;
  (setq
   temps (org-map-entries (lambda()
			    (let(z) (setq z (org-entry-get nil "Effort")))))		;; collecte "Effort"
   titre (org-map-entries (lambda()
			    (let(w)
			      (if (looking-at org-complex-heading-regexp)
				  (setq w (substring-no-properties (match-string 4)))))))	;; collecte "Item"
   lola (org-map-entries (lambda()
   			   (let(x)
			     (if (string= (org-entry-get nil "SCHEDULED") "nil")
				 (setq x (org-entry-get nil "TIMESTAMP"))
			       (setq x (org-entry-get nil "SCHEDULED"))))))
   sum   0											;; initiatlisations
   dates '()
   premier 365
   dernier 0
   )
  ;;***********************************************;;
;; **  Additionner Effort en secondes             ;;;
  ;;***********************************************;;
  (while titre											;; pour chaque "Item"
    (setq
     temps-x (pop temps)									;; retenir "Effort"
     titre-x (pop titre)									;; retenir "Item"
     )
    (if (string= temps-x "nil")									;; si pas de "Effort" ...
	(message "nothing")									;; sortir
      (progn											;; ... sinon
	(setq sum (+ sum (org-time-string-to-seconds temps-x)))))				;; additionner "Effort"'s
    )
  ;;********************************************************;;
;; **  Définition des dates de début et de fin de l'étude   ;;;
  ;;********************************************************;;
  (while lola											;; si "date"
    (if (string= (car lola) "nil")
	(pop lola)
      (progn
	(setq
	 reference (pop lola)
	 premier (min
		  (- (time-to-day-in-year (date-to-time reference)) 1)				;; sortir "début"
		  premier)
	 dernier (max
		  (- (time-to-day-in-year (date-to-time reference)) 1)
		  dernier)
	 )))
    )											;; sortir "fin"
  ;;***********************************************;;
;; ** préparation des variable en vue de leur inscription dans le heading et en vue de leur exportation dans le fichier xfdf
  ;;***********************************************;;
  (setq
   date-debut (format-time-string "%d-%m" (days-to-time premier))
   date-fin (format-time-string "%d-%m" (days-to-time dernier))
   taux (string-to-number (org-entry-get nil "Taux"))
   frais (org-entry-get nil "Frais")
   total-secondes (/ sum 3600.00)
   total-s (format "%.2f" total-secondes)
   total-d (replace-regexp-in-string "," "." total-s)
   tarif (* (string-to-number total-s) taux)				;; HT
   total-h (org-time-seconds-to-string sum)
   )
  (save-excursion
    (goto-char (point-min))
    (looking-at org-complex-heading-regexp)
    (setq
     etude (substring-no-properties (match-string 4))
     client (substring (substring-no-properties (match-string 5)) 1 -1)
     ht (format "%.2f" tarif)
     tva (format "%.2f" (* tarif 0.2))
     ttc (format "%.2f" (* tarif 1.2))
     net (format "%.2f" (/ (* tarif 1.2) 2.041639))
     lieux (org-entry-get nil "Lieux")
     )
    (org-entry-put nil "Etude" etude)
    (org-entry-put nil "Client" client)
    (org-entry-put nil "Total-H" total-h)
    (org-entry-put nil "Total-D" total-d)
    (org-entry-put nil "HT"  ht)
    (org-entry-put nil "TVA" tva)
    (org-entry-put nil "TTC" ttc)
    (org-entry-put nil "NET" net)
    (org-entry-put nil "Date_Debut" date-debut)
    (org-entry-put nil "Date_fin" date-fin)
    ;;***********************************************;;
;; **            début de l'exportation           ;;;
    ;;***********************************************;;
    (setq
     base (expand-file-name "~/org/facturation/")
     destination (concat base (format-time-string "%m-%Y") "/")
     )
    (if (not (file-exists-p destination))
	(make-directory destination))
    )
;; ** fichier client
  (progn
    (find-file "~/org/clients.org")
    (widen)
    (goto-char (point-min))
    (search-forward client)
    (org-narrow-to-subtree)
    (setq ensemble (org-entry-properties))
    (setq societe (org-entry-get nil "Texte1"))
    (kill-buffer)
    )
  ;;***********************************************;;
;; **            creation du fichier de base du formulaire
  ;;***********************************************;;
  (with-temp-buffer
    (insert "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n
  <xfdf xmlns=\"http://nous.adobe.com/xfdf/\" xml:space=\"default\">\n
      <fields>\n")
    (setq
     recordon "<field name=\""
     valueon "\"><value>"
     recordoff "</value></field>"
     )
    (insert (concat	    recordon "Texte15"		valueon "Aziz Yemloul"				recordoff "\n")
	    (concat 	    recordon "Texte20"		valueon etude					recordoff "\n")
	    (concat 	    recordon "Texte21"		valueon total-d					recordoff "\n")
	    (concat 	    recordon "Texte22"		valueon (number-to-string taux)			recordoff "\n")
	    (concat 	    recordon "Texte23"		valueon ht					recordoff "\n")
	    (concat 	    recordon "Texte36"		valueon ht					recordoff "\n")
	    (concat 	    recordon "Texte37"		valueon tva					recordoff "\n")
	    (concat 	    recordon "Texte38"		valueon ttc					recordoff "\n")
	    (concat 	    recordon "Texte34"		valueon lieux					recordoff "\n")
	    (concat 	    recordon "Texte35"		valueon (concat date-debut "---" date-fin)	recordoff "\n")
	    (concat 	    recordon "Texte44"		valueon (format-time-string "%d-%m-%Y")		recordoff "\n")
	    (concat 	    recordon "Texte41"		valueon frais					recordoff "\n")
	    )
    (while ensemble
      (setq
       unite (pop ensemble)
       propriete (car unite)
       valeur (cdr unite)
       )
      (if (or (member propriete '("Taux2" "TAGS" "FILE" "ALLTAGS" "BLOCKED" "CATEGORY")) (member valeur '("#")))
	  (message "")
	(insert (concat recordon propriete valueon valeur recordoff "\n")))
      )
    (insert "</fields></xfdf>")
    (setq
     xfdfdoc (expand-file-name (concat destination societe "-" etude "-" date-fin ".xfdf"))
     xfdflink (concat societe "-" etude "-" date-fin ".xfdf")
     pdf (expand-file-name (concat destination societe "-" etude "-" date-fin ".pdf"))
     )
    (append-to-file (point-min) (point-max) xfdfdoc)
    )
  (org-entry-put nil "Facture" (concat "[[file://" xfdfdoc "][" xfdflink "]]"))
  ;;***********************************************;;
;; **            correction des accents non pris en charge dans le formulaire
  ;;***********************************************;;
  ;; (progn
  ;;   (find-file xfdfdoc)
  ;;   (goto-char (point-min))
  ;;   (replace-string "Société" "Soci&#233;t&#233;")
  ;;   (goto-char (point-min))
  ;;   (replace-string "Représentée par" "Repr&#233;sent&#233;e par")
  ;;   (goto-char (point-min))
  ;;   (replace-string "Qualité" "Qualit&#233;")
  ;;   (goto-char (point-min))
  ;;   (replace-string "Période" "P&#233;riode")
  ;;   (goto-char (point-min))
  ;;   (replace-string "Société" "Soci&#233;t&#233;")
  ;;   (goto-char (point-min))
  ;;   (replace-string "_" " ")
  ;;   (goto-char (point-min))
  ;;   (replace-string "dordre" "d'ordre")
  ;;   (save-buffer)
  ;;   (kill-buffer)
  ;;   )
  ;;***********************************************;;
;; **            remplissage du formulaire et apposition de la signature
  ;;***********************************************;;
  (call-process "pdftk" nil "*scratch*" nil (expand-file-name "~/org/facturation/ABC Portage_Bon de commande_TYPE FR.pdf") "fill_form" xfdfdoc "output" pdf)
  (call-process "pdftk" nil "*scratch*" nil pdf "burst" "output" (expand-file-name "~/org/facturation/page_%d.pdf"))
  (call-process "convert" nil "*scratch*" nil "-density" "100" (expand-file-name "~/org/facturation/page_1.pdf") (expand-file-name "~/org/facturation/page_1.png"))
  (call-process "convert" nil "*scratch*" nil "-density" "100" (expand-file-name "~/org/facturation/page_2.pdf") (expand-file-name "~/org/facturation/page_2.png"))
  ;; (call-process "composite" nil "*scratch*" nil "-geometry"  "228x101+560+950" (expand-file-name "~/org/facturation/signature.png")  (expand-file-name "~/org/facturation/page_1.png")  (expand-file-name "~/org/facturation/page_1b.png"))
  (call-process "composite" nil "*scratch*" nil "-geometry"  "228x101+560+970" (expand-file-name "~/org/facturation/signature.png")  (expand-file-name "~/org/facturation/page_1.png")  (expand-file-name "~/org/facturation/page_1b.png"))
  (call-process "composite" nil "*scratch*" nil "-geometry"  "228x101+560+920" (expand-file-name "~/org/facturation/signature.png")  (expand-file-name "~/org/facturation/page_2.png")  (expand-file-name "~/org/facturation/page_2b.png"))
  (call-process "convert" nil "*scratch*" nil "-density" "100" (expand-file-name "~/org/facturation/page_1b.png") (expand-file-name "~/org/facturation/page_1.pdf"))
  (call-process "convert" nil "*scratch*" nil "-density" "100" (expand-file-name "~/org/facturation/page_2b.png") (expand-file-name "~/org/facturation/page_2.pdf"))
  (call-process "pdftk" nil "*scratch*" nil (expand-file-name "~/org/facturation/page_1.pdf") (expand-file-name "~/org/facturation/page_2.pdf") "cat" "output" pdf)
  (start-process "my-process2" "*scratch*"  "evince" pdf)
  (start-process "my-process3" "*scratch*"
  		 "rm"
  		 (concat base "doc_data.txt")
  		 (expand-file-name "~/org/facturation/page_1b.png")
  		 (expand-file-name "~/org/facturation/page_1.pdf")
  		 (expand-file-name "~/org/facturation/page_1.png")
  		 (expand-file-name "~/org/facturation/page_2b.png")
  		 (expand-file-name "~/org/facturation/page_2.pdf")
  		 (expand-file-name "~/org/facturation/page_2.png")
  		 )
  )
;; * parseRealEffort
(defun parse-realeffort()
  "Déduire le temps de la réunion à partir du premier et du dernier marquage temps du document et le convertir en propriété Real"
  (interactive)
  (goto-char (point-min))
  (search-forward-regexp "^- \\([0-9]\\{0,2\\}\\):\\{0,1\\}\\([0-9]\\{0,2\\}\\):\\{0,1\\}\\([0-9]\\{1,2\\}\\) ::")
  (setq hd (match-string 1))
  (setq md (match-string 2))
  (goto-char (point-max))
  (search-backward-regexp "^- \\([0-9]\\{0,2\\}\\):\\{0,1\\}\\([0-9]\\{0,2\\}\\):\\{0,1\\}\\([0-9]\\{1,2\\}\\) ::")
  (setq hf (match-string 1))
  (setq mf (match-string 2))
  (setq effort
	(org-time-seconds-to-string (-
				     (org-time-string-to-seconds (concat hf ":" mf))
				     (org-time-string-to-seconds (concat hd ":" md))
				     )))
  (goto-char (point-min))
  (org-entry-put nil "Real" effort))

;; * parseEffortAll
(defun parse-effort-all()
  "Pour chaque heading chercher une expression du type HH:MM-HH:MM et la convertir en propriété Effort"
  (interactive)
  (while		;      1        2          3                   4                 5                  6             7
      (re-search-forward "\\(\\*\\)\\(.*\\)\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)-\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)\\(.*\\)$" nil t)
    (setq
     heure-debut (concat (match-string 3) ":" (match-string 4))
     heure-fin (concat (match-string 5) ":" (match-string 6))
     debut-en-secondes (aziz-time-string-to-seconds heure-debut)
     fin-en-secondes (aziz-time-string-to-seconds heure-fin)
     effort (org-time-seconds-to-string (- fin-en-secondes debut-en-secondes))
     )
    (org-entry-put nil "Effort" effort)
    ))

;; * aAnalyser
(defun ht(s ta op)
  "HT prend en argument un nombre de secondes (s) et une expression string"
  (setq
   unite (/ s 3600.00)
   ;;ta ;;(if (org-entry-get nil "FAC_Taux") (string-to-number (org-entry-get nil "FAC_Taux")) 45.0)
   saltaux (if (org-entry-get nil "SAL_Taux") (string-to-number (org-entry-get nil "SAL_Taux")) 25.0)
   facture_ht (* ta unite)
   facture_tva (* 0.2 (* ta unite))
   facture_ttc (* 1.2 (* ta unite))
   facture_net (/ (* ta unite) 2.041639)

   salaire_brut (* saltaux unite)
   salaire_net1 (* (* saltaux unite) 0.83)
   conge (/ (* salaire_brut 10) 100)
   primvaca (* (+ salaire_brut conge) (/ 4.0 100))
   base (+ salaire_brut conge primvaca)
   char-sala (* base 0.21273463378726537)
   char-patro (* base 0.42602816287026807)
   salaire_cout (+ base char-patro)
   salaire_net2 (- base char-sala)
   salaire_impot (* salaire_net2 0.14)
   )
  (cond
   ((string= op "un")  unite)
   ((string= op "facht")  facture_ht)
   ((string= op "factva") facture_tva)
   ((string= op "facttc") facture_ttc)
   ((string= op "facnet") facture_net)
   ((string= op "salbrut")  salaire_brut)
   ((string= op "salnet1")  salaire_net1)
   ((string= op "salnet2")  salaire_net2)
   ((string= op "salcout")  salaire_cout)
   ((string= op "impot")  salaire_impot)
   (t 0)
   )
  )

(defun gaph(x)
  "X est un string. GAPH cherche une formule de type HH:MM-HH:MM dans X, calcul
la durée entre les deux horaires et retourne une liste (secondes \"HH:MM:SS\")

Exemple:
 (gaph \"20:00-22:30\")

 -->(9000 \"02:30:00\")
"
  (with-temp-buffer
    (insert x)
    (dd)
    (while (re-search-forward "\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)-\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)" nil t)
      (setq
       heure-debut (concat (match-string 1) ":" (match-string 2))
       heure-fin (concat (match-string 3) ":" (match-string 4))
       debut-en-secondes (aziz-time-string-to-seconds heure-debut)
       fin-en-secondes (aziz-time-string-to-seconds heure-fin)
       temps-en-secondes (- fin-en-secondes debut-en-secondes)
       effort (org-time-seconds-to-string (- fin-en-secondes debut-en-secondes))
       )
      )
    )
  (list temps-en-secondes effort)
  )

(defun toSeconds(x)
  "X est un string. GAPH cherche une formule de type HH:MM-HH:MM dans X, calcul
la durée entre les deux horaires et retourne une liste (secondes \"HH:MM:SS\")

Exemple:
 (gaph \"20:00-22:30\")

 -->(9000 \"02:30:00\")
"
  (with-temp-buffer
    (insert x)
    (dd)
    (while (re-search-forward "\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)-\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)" nil t)
      (setq
       heure-debut (concat (match-string 1) ":" (match-string 2))
       heure-fin (concat (match-string 3) ":" (match-string 4))
       debut-en-secondes (aziz-time-string-to-seconds heure-debut)
       fin-en-secondes (aziz-time-string-to-seconds heure-fin)
       temps-en-secondes (- fin-en-secondes debut-en-secondes)
       effort (org-time-seconds-to-string (- fin-en-secondes debut-en-secondes))
       )
      )
    )
  temps-en-secondes)

(defun whatefort()
  (with-current-buffer (buffer-name)
    (org-entry-get nil "Effort")
    )
  )

;; * MULTI BDC
(defun multibdc()
  (interactive)
  (save-excursion
    (setq
     recordon			"<field name=\""
     value			"\"><value>"
     recordoff			"</value></field>"
     bdc-tag			"+BDC"
     etude-tag			"+ET"
     duration-regexp		"\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)-\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)"
     duration-property-string	"Effort"
     client			(org-map-entries (lambda()
						   (let(w)
						     (if (looking-at org-complex-heading-regexp)
							 (setq w (substring-no-properties (match-string 4)))))) bdc-tag)

     etudes-headings		(org-map-entries (lambda()
						   (let(w)
						     (if (looking-at org-complex-heading-regexp)
							 (setq w (substring-no-properties (match-string 4)))))) etude-tag)

     arbre			(mapcar (lambda(ß)
					  (save-excursion
					    (search-forward ß)
					    (list ß
						  (cdr (org-map-entries (lambda()
									  (let(z)
									    (if (looking-at org-complex-heading-regexp)
										(setq z (substring-no-properties (match-string 4)))))) nil 'tree))
						  )))
					etudes-headings)

     calcul			(mapcar (lambda(boom)
					  (save-excursion
					    (search-forward (car boom))
					    (setq temps (mapcar (lambda(zoom) (toSeconds zoom)) (cadr boom)))
					    )
					  (list
					   (car boom)
					   (apply '+ temps))
					  )
					arbre)

     details			(mapcar (lambda(lulu)
					  (setq ta (read-from-minibuffer (concat "Tarif horaire pour " (car lulu) " : ") "45.0" nil t nil "45.0"))
					  (list
					   (car lulu)
					   (ht (cadr lulu) ta "un")
					   ta
					   (ht (cadr lulu) ta "facht")
					   (ht (cadr lulu) ta "factva")
					   (ht (cadr lulu) ta "facttc")
					   ))
					calcul)
     dates			(strip-duplicates (delq nil (org-map-entries (lambda()
							     (let(x)
							       (if (string= (org-entry-get nil "SCHEDULED") "nil")
								   (setq x (org-entry-get nil "TIMESTAMP"))
								 (setq x (org-entry-get nil "SCHEDULED")))
								 )))))
     dates			(mapcar (lambda(ßßßß) (list (time-to-days (date-to-time ßßßß)) ßßßß)) dates)

     debutfin			(list (format-time-string "%d-%m-%Y" (org-time-string-to-time (cadr (assoc (apply 'min (mapcar 'car dates)) dates))))
				      (format-time-string "%d-%m-%Y" (org-time-string-to-time (cadr (assoc (apply 'max (mapcar 'car dates)) dates))))
				      )
     totalht			(apply '+ (mapcar 'cadddr details))
     totaltva			(apply '+ (mapcar (lambda(z) (nth 4 z)) details))
     totalttc			(apply '+ (mapcar (lambda(z) (nth 5 z)) details))
     )

    (progn
      (find-file "~/org/clients.org")
      (widen)
      (goto-char (point-min))
      (search-forward (car client))
      (setq ensemble (org-entry-properties))
      (kill-buffer)
      )

    (with-temp-buffer
      (insert "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<xfdf xmlns=\"http://nous.adobe.com/xfdf/\" xml:space=\"default\">\n<fields>\n")
      (mapcar (lambda(malist)
	      (if (and (string-match "Texte" (car malist)) (not (string-match "#" (cdr malist))))
		  (insert (concat recordon (car malist) value (cdr malist) recordoff "\n")))) ensemble)
      (if (< (length details) 4) (setq compteur 19) (setq compteur 15))
      (mapcar (lambda(mesdetails)
		(insert (concat "\n"
				recordon "Texte" (number-to-string (setq compteur (+ compteur 1))) value (nth 0 mesdetails)                    recordoff "\n"
				recordon "Texte" (number-to-string (setq compteur (+ compteur 1))) value (number-to-string (nth 1 mesdetails)) recordoff "\n"
				recordon "Texte" (number-to-string (setq compteur (+ compteur 1))) value (number-to-string (nth 2 mesdetails)) recordoff "\n"
				recordon "Texte" (number-to-string (setq compteur (+ compteur 1))) value (number-to-string (nth 3 mesdetails)) recordoff "\n"
				))) details)
      (insert
       (concat "\n"
	recordon "Texte15" value "Aziz Yemloul"						recordoff "\n"
	recordon "Texte35" value (concat "Du " (car debutfin) " au " (cadr debutfin))	recordoff "\n"
	recordon "Texte36" value (number-to-string totalht)				recordoff "\n"
	recordon "Texte37" value (number-to-string totaltva)				recordoff "\n"
	recordon "Texte38" value (number-to-string totalttc)				recordoff "\n"
	recordon "Texte44" value (format-time-string "%d-%m-%Y")			recordoff "\n"
	recordon "Texte45" value (format-time-string "%d-%m-%Y")			recordoff "\n"
	))
      (insert "</fields></xfdf>")
      (setq
       base					(expand-file-name "~/org/facturation/")
       destination				(concat base (format-time-string "%m-%Y") "/")
       xfdfdoc					(concat destination (car client) "_" (substring (cadr debutfin) 0 10) ".xfdf")
       pdf					(concat destination (car client) "_" (substring (cadr debutfin) 0 10) ".pdf")
       )
      (if (not (file-exists-p destination))
	  (make-directory destination))
      (write-file xfdfdoc)
      )
    (dd)

    (org-entry-put nil "Facture" (concat "[[shell:evince \"" pdf "\"][" (file-name-nondirectory pdf) "]]"))
    (setq script (concat
		  "#!/bin/bash" "\n"
		  "pdftk \"$HOME/org/facturation/ABC Portage_Bon de commande_TYPE FR.pdf\" fill_form " xfdfdoc " output " pdf "\n"
		  "pdftk " pdf " burst output $HOME/org/facturation/page_%d.pdf" "\n"
		  "convert -density 100 $HOME/org/facturation/page_1.pdf $HOME/org/facturation/page_1.png" "\n"
		  "convert -density 100 $HOME/org/facturation/page_2.pdf $HOME/org/facturation/page_2.png" "\n"
		  "composite -geometry 228x101+560+970 $HOME/org/facturation/signature.png $HOME/org/facturation/page_1.png $HOME/org/facturation/page_1b.png" "\n"
		  "composite -geometry 228x101+560+920 $HOME/org/facturation/signature.png $HOME/org/facturation/page_2.png $HOME/org/facturation/page_2b.png" "\n"
		  "convert -density 100 $HOME/org/facturation/page_1b.png $HOME/org/facturation/page_1.pdf" "\n"
		  "convert -density 100 $HOME/org/facturation/page_2b.png $HOME/org/facturation/page_2.pdf" "\n"
		  "pdftk $HOME/org/facturation/page_1.pdf $HOME/org/facturation/page_2.pdf cat output " pdf "\n"
;		  "evince " pdf "\n"
		  "rm $HOME/org/facturation/page_1.pdf $HOME/org/facturation/page_2.pdf $HOME/org/facturation/page_1b.png $HOME/org/facturation/page_2b.png $HOME/org/facturation/page_1.png $HOME/org/facturation/page_2.png" "\n"))

    ;; (setq compteurA 0)
    ;; (mapcar (lambda(mesdetails)
    ;; 	      (org-entry-put nil (concat	"Mission_"	(number-to-string (setq compteurA (+ compteurA 1))))	(nth 0 mesdetails))
    ;; 	      (org-entry-put nil (concat	"Unité_"	(number-to-string compteurA))				(number-to-string (nth 1 mesdetails)))
    ;; 	      (org-entry-put nil (concat	"HT_"		(number-to-string compteurA))				(number-to-string (nth 3 mesdetails)))
    ;; 	      (org-entry-put nil (concat	"TTC_"		(number-to-string compteurA))				(number-to-string (nth 5 mesdetails)))
    ;; 	      ) details)

    (with-temp-buffer
      (insert script)
      (write-file "~/org/facturation/bdc.sh"))
    (start-process "my-process" "*scratch*"  "~/org/facturation/bdc.sh")
    )
  )

;; * multibdc relégé
  ;;   ;; POUR CHAQUE ÉTUDE
  ;;   (while etudes-headings
  ;;     (setq current-etude-heading (pop etudes-headings)
  ;; 	    current-etude-time-sum 0)
  ;;     (dd)
  ;;     (search-forward current-etude-heading)
  ;;     (setq missions-list (cdr (org-map-entries (lambda()
  ;; 						  (let(z)
  ;; 						    (if (looking-at org-complex-heading-regexp)
  ;; 							(setq z (substring-no-properties (match-string 4)))))) nil 'tree))

  ;; 	    etude-arbre mission-list)
  ;;     ;; POUR CHAQUE MISSION
  ;;     (while missions-list
  ;; 	(setq current-mission (pop missions-list))
  ;; 	(search-forward current-mission)

  ;; 	(if (string-match duration-regexp current-mission)		(setq temps-list (gaph current-mission)))
  ;; 	(if (not (string-match duration-regexp current-mission))	(setq temps-list (list (org-time-string-to-seconds (whatefort)) (whatefort))))
  ;; 	(if (not (whatefort))						(org-entry-put nil duration-property-string  (nth 1 temps-list)))
  ;; 	(if (not (string= (whatefort) (nth 1 temps-list)))		(org-entry-put nil "WARNING"  (nth 1 temps-list)))
  ;; 	(setq current-etude-time-sum (+ (nth 0 temps-list) current-etude-time-sum))
  ;; 	)
  ;;     ;; RETOUR À L'ÉTUDE
  ;;     (dd)
  ;;     (search-forward current-etude-heading)


  ;;     (org-entry-put nil duration-property-string (org-time-seconds-to-string current-etude-time-sum))
  ;;     (org-entry-put nil "FAC_Taux"	(number-to-string (read-from-minibuffer (concat "Tarif horaire pour " current-etude-heading " : ") "45.0" nil t nil "45.0")))
  ;;     (org-entry-put nil "UNIT"		(format "%.2f"	(ht current-etude-time-sum "un")))
  ;;     (org-entry-put nil "FAC_HT"	(format "%.2f"	(ht current-etude-time-sum  "facht")))
  ;;     (org-entry-put nil "FAC_TVA"	(format "%.2f"	(ht current-etude-time-sum "factva")))
  ;;     (org-entry-put nil "FAC_TTC"	(format "%.2f"	(ht current-etude-time-sum "facttc")))
  ;;     (org-entry-put nil "FAC_NET"	(format "%.2f"	(ht current-etude-time-sum "facnet")))
  ;;     (setq ttoo (org-entry-get nil "FAC_Taux"))

  ;;     ;; POUR CHAQUE MISSION
  ;;     (while etude-arbre
  ;; 	(search-forward (pop etude-arbre))
  ;; 	(org-entry-put nil "FAC_Taux" ttoo)
  ;; 	(org-entry-put nil "UNIT"     (format "%.2f" (ht (org-time-string-to-seconds (whatefort)) "un")))
  ;; 	(org-entry-put nil "FAC_NET"  (format "%.2f" (ht (org-time-string-to-seconds (whatefort)) "facnet")))
  ;; 	(org-entry-put nil "FAC_HT"   (format "%.2f" (ht (org-time-string-to-seconds (whatefort))  "facht")))
  ;; 	(org-entry-put nil "FAC_TVA"  (format "%.2f" (ht (org-time-string-to-seconds (whatefort)) "factva")))
  ;; 	(org-entry-put nil "FAC_TTC"  (format "%.2f" (ht (org-time-string-to-seconds (whatefort)) "facttc")))
  ;; 	)
  ;;     )
  ;;   ;; POUR L'ENSEMBLE

  ;;   )
  ;; )

 ;; (call-process "pdftk" nil "*scratch*" nil (expand-file-name "~/org/facturation/ABC Portage_Bon de commande_TYPE FR.pdf") "fill_form" xfdfdoc "output" pdf)
    ;; (call-process "pdftk" nil "*scratch*" nil pdf "burst" "output" (expand-file-name "~/org/facturation/page_%d.pdf"))
    ;; (call-process "convert" nil "*scratch*" nil "-density" "100" (expand-file-name "~/org/facturation/page_1.pdf") (expand-file-name "~/org/facturation/page_1.png"))
    ;; (call-process "convert" nil "*scratch*" nil "-density" "100" (expand-file-name "~/org/facturation/page_2.pdf") (expand-file-name "~/org/facturation/page_2.png"))
    ;; ;; (call-process "composite" nil "*scratch*" nil "-geometry"  "228x101+560+950" (expand-file-name "~/org/facturation/signature.png")  (expand-file-name "~/org/facturation/page_1.png")  (expand-file-name "~/org/facturation/page_1b.png"))
    ;; (call-process "composite" nil "*scratch*" nil "-geometry"  "228x101+560+970" (expand-file-name "~/org/facturation/signature.png")  (expand-file-name "~/org/facturation/page_1.png")  (expand-file-name "~/org/facturation/page_1b.png"))
    ;; (call-process "composite" nil "*scratch*" nil "-geometry"  "228x101+560+920" (expand-file-name "~/org/facturation/signature.png")  (expand-file-name "~/org/facturation/page_2.png")  (expand-file-name "~/org/facturation/page_2b.png"))
    ;; (call-process "convert" nil "*scratch*" nil "-density" "100" (expand-file-name "~/org/facturation/page_1b.png") (expand-file-name "~/org/facturation/page_1.pdf"))
    ;; (call-process "convert" nil "*scratch*" nil "-density" "100" (expand-file-name "~/org/facturation/page_2b.png") (expand-file-name "~/org/facturation/page_2.pdf"))
    ;; (call-process "pdftk" nil "*scratch*" nil (expand-file-name "~/org/facturation/page_1.pdf") (expand-file-name "~/org/facturation/page_2.pdf") "cat" "output" pdf)
    ;; (start-process "my-process2" "*scratch*"  "evince" pdf)
    ;; (start-process "my-process3" "*scratch*"
    ;; 		   "rm"
    ;; 		   (concat base "doc_data.txt")
    ;; 		   (expand-file-name "~/org/facturation/page_1b.png")
    ;; 		   (expand-file-name "~/org/facturation/page_1.pdf")
    ;; 		   (expand-file-name "~/org/facturation/page_1.png")
    ;; 		   (expand-file-name "~/org/facturation/page_2b.png")
    ;; 		   (expand-file-name "~/org/facturation/page_2.pdf")
    ;; 		   (expand-file-name "~/org/facturation/page_2.png")
    ;; 		   )




;; (defun multibdc()
;;   (interactive)
;;   (save-excursion
;;     (dd)
;;     (setq counter 0
;; 	  etudes '())
;;     (setq etudes (org-map-entries (lambda()
;; 				    (let(w)
;; 				      (if (looking-at org-complex-heading-regexp)
;; 					  (setq w (substring-no-properties (match-string 4)))))
;; 				    ) "+ET"))

;;     (message "%S" etudes)
;;     (dd)
;;     (while etudes
;;       (setq counter (+ 1 counter)
;; 	    etude (pop etudes))

;;       (search-forward etude)
;;       (setq reference (org-map-entries (lambda()
;; 					 (let(z)
;; 					   (if (looking-at org-complex-heading-regexp)
;; 					       (setq z (substring-no-properties (match-string 4)))))) nil 'tree)
;; 	    mission (pop reference)
;; 	    total-temps 0
;; 	    dates '())

;;       (if (looking-at org-complex-heading-regexp)
;; 	  (setq client (substring (substring-no-properties (match-string 5)) 4 -1)))


;;       (save-excursion
;; 	(while reference
;; 	  (setq ref (pop reference))

;; 	  (if (string-match "\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)-\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)" ref)
;; 	      (progn
;; 		(with-temp-buffer
;; 		  (insert ref)
;; 		  (dd)
;; 		  (while (re-search-forward "\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)-\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)" nil t)
;; 		    (setq
;; 		     heure-debut (concat (match-string 1) ":" (match-string 2))
;; 		     heure-fin (concat (match-string 3) ":" (match-string 4))
;; 		     debut-en-secondes (aziz-time-string-to-seconds heure-debut)
;; 		     fin-en-secondes (aziz-time-string-to-seconds heure-fin)
;; 		     temps-en-secondes (- fin-en-secondes debut-en-secondes)
;; 		     effort (org-time-seconds-to-string (- fin-en-secondes debut-en-secondes))
;; 		     )
;; 		    (setq total-temps (+ temps-en-secondes total-temps))
;; 		    )
;; 		  )
;; 		(dd)
;; 		(search-forward ref)
;; 		(org-entry-put nil "Effort" effort))
;; 	    (if (not (string= (org-entry-get nil "Effort") "nil"))
;; 		(setq total-temps (+ (org-time-string-to-seconds (org-entry-get nil "Effort")) total-temps))
;; 	      (org-entry-put nil "Effort" "0")))
;; 	  )
;; 	)
;;       (progn
;; 	(find-file "~/org/clients.org")
;; 	(widen)
;; 	(goto-char (point-min))
;; 	(goto-char  (search-forward client))
;; 	(org-narrow-to-subtree)
;; 	(setq ensemble (org-entry-properties))
;; 	(kill-buffer)
;; 	)
;;       ;; (while ensemble
;;       ;; 	(setq
;;       ;; 	 unite (pop ensemble)
;;       ;; 	 propriete (car unite)
;;       ;; 	 valeur (cdr unite)
;;       ;; 	 )
;;       ;; 	(if (or (member propriete '("Taux2" "TAGS" "FILE" "ALLTAGS" "BLOCKED" "CATEGORY")) (member valeur '("#")))
;;       ;; 	    (message "")
;;       ;; 	  (org-entry-put nil propriete valeur)
;;       ;; 	  )
;;       ;; 	)
;;       (org-entry-put nil "Effort" (org-time-seconds-to-string total-temps))
;;       (org-entry-put nil "Taux" (number-to-string (read-from-minibuffer "Tarif horaire: " "45.0" nil t nil "45.0")))
;;       (org-entry-put nil "HT" (format "%.2f" (* (string-to-number (org-entry-get nil "Taux")) (/ total-temps 3600.00))))
;;       )
;;     )
;;   )





;; * multiSalaire

(defun multisalaire()
  (interactive)
  (save-excursion
    (setq
     etude-tag "+ET"
     duration-regexp "\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)-\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)"
     duration-property-string "Effort"
     etudes-headings (org-map-entries
		      (lambda()
			(let(w)
			  (if (looking-at org-complex-heading-regexp)
			      (setq w (substring-no-properties (match-string 4)))))) etude-tag))
    ;; POUR CHAQUE ÉTUDE
    (while etudes-headings
      (setq current-etude-heading (pop etudes-headings)
	    current-etude-time-sum 0)
      (dd)
      (search-forward current-etude-heading)
      (setq etude-arbre (org-map-entries
			 (lambda()
			   (let(z)
			     (if (looking-at org-complex-heading-regexp)
				 (setq z (substring-no-properties (match-string 4)))))) nil 'tree)

	    garbage-etude-heading (pop etude-arbre)
	    missions-list etude-arbre)
      ;; POUR CHAQUE MISSION
      (while missions-list
	(setq current-mission (pop missions-list))
	(search-forward current-mission)
	(if (string-match duration-regexp current-mission)
	    (setq temps-list (gaph current-mission)))
	(if (not (string-match duration-regexp current-mission))
	    (setq temps-list (list (org-time-string-to-seconds (whatefort)) (whatefort))))

	(if (not (whatefort))
	    (org-entry-put nil duration-property-string  (nth 1 temps-list)))
	(if (not (string= (whatefort) (nth 1 temps-list)))
	    (org-entry-put nil "WARNING"  (nth 1 temps-list)))

	(setq current-etude-time-sum (+ (nth 0 temps-list) current-etude-time-sum))
	)
      ;; POUR CHAQUE ÉTUDE
      (dd)
      (search-forward current-etude-heading)
      (org-entry-put nil duration-property-string (org-time-seconds-to-string current-etude-time-sum))
      (org-entry-put nil "SAL_Taux" (number-to-string (read-from-minibuffer (concat "Tarif horaire pour " current-etude-heading " : ") "25.0" nil t nil "25.0")))
      (org-entry-put nil "UNIT" (format "%.2f" (ht current-etude-time-sum "un")))
      (org-entry-put nil "SAL_Brute"   (format "%.2f" (ht current-etude-time-sum "salbrut")))
      (org-entry-put nil "SAL_NET1"   (format "%.2f" (ht current-etude-time-sum "salnet1")))
      (org-entry-put nil "SAL_NET2"   (format "%.2f" (ht current-etude-time-sum "salnet2")))
      (org-entry-put nil "SAL_COUT"   (format "%.2f" (ht current-etude-time-sum "salcout")))
      (org-entry-put nil "SAL_IMPOT"   (format "%.2f" (ht current-etude-time-sum "impot")))
      (setq ttoo (org-entry-get nil "SAL_Taux"))
      ;; POUR CHAQUE MISSION
      (while etude-arbre
	(search-forward (pop etude-arbre))
	(org-entry-put nil "SAL_Taux" ttoo)
	(org-entry-put nil "UNIT" (format "%.2f" (ht (org-time-string-to-seconds (whatefort)) "un")))
	(org-entry-put nil "SAL_Brute"   (format "%.2f" (ht (org-time-string-to-seconds (whatefort)) "salbrut")))
	(org-entry-put nil "SAL_NET1"   (format "%.2f" (ht  (org-time-string-to-seconds (whatefort)) "salnet1")))
	(org-entry-put nil "SAL_NET2"   (format "%.2f" (ht  (org-time-string-to-seconds (whatefort)) "salnet2")))
	(org-entry-put nil "SAL_COUT"   (format "%.2f" (ht  (org-time-string-to-seconds (whatefort)) "salcout")))
	(org-entry-put nil "SAL_IMPOT"   (format "%.2f" (ht (org-time-string-to-seconds (whatefort)) "impot")))
	)
      )
    ;; POUR L'ENSEMBLE
    )
  )

;; * ehseb
(defun ehseb()
  "Si pas de marquage temps dans le heading pour déduire Effort, trouver Real seulement, faire les deux sinon"
  (interactive)
  (goto-char (point-min))
  (if (eq (re-search-forward "\\(\\*\\)\\(.*\\)\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)-\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)\\(.*\\)$" nil t) 'nil)
      (parse-realeffort)
    (progn
      (parse-effort-all)
      (parse-realeffort))))

;; * azizTimeStringToSeconds
(defun aziz-time-string-to-seconds (s)
  "Convert a string HH:MM to a number of seconds."
  (string-match "\\([0-9]+\\):\\([0-9]+\\)" s)
  (setq hour (string-to-number (match-string 1 s))
	min (string-to-number (match-string 2 s))
	sec 0)
  (+ (* hour 3600) (* min 60) sec))
;; * junk
;; (
;;  ("Etude Nesquick prise de notes"		27000	45.0	7.5	337.5	67.5	405.0	165.3083625459741)
;;  ("Etude Nesquick mise à plat"			3600	50.0	1.0	45.0	9.0	54.0	22.04111500612988)
;;  ("Etude Camembert Algérie mise à plat"		3600	2300.0	1.0	45.0	9.0	54.0	22.04111500612988)
;;  ("Etude Cantal prise de notes"			12600	45.0	3.5	157.5	31.5	189.0	77.14390252145458)
;;  )


;; (
;;  ("Etude Nesquick prise de notes"		27000	7.5	337.5	67.5	405.0	165.3083625459741)
;;  ("Etude Nesquick mise à plat"			3600	1.0	150.0	30.0	180.0	73.47038335376627)
;;  ("Etude Camembert Algérie mise à plat"		3600	1.0	2300.0	460.0	2760.0	1126.5458780910826)
;;  ("Etude Cantal prise de notes"			12600	3.5	157.5	31.5	189.0	77.14390252145458)
;;  )


;; (						prix_u	nbr	ht	tva	ttc	net
;;  ("Etude Nesquick prise de notes"	27000	45.0	7.5	337.5	67.5	405.0	165.3083625459741)
;;  ("Etude Nesquick mise à plat"		3600	150.0	1.0	150.0	30.0	180.0	73.47038335376627)
;;  ("Etude Camembert Algérie mise à plat" 3600	2300.0	1.0	2300.0	460.0	2760.0	1126.5458780910826)
;;  ("Etude Cantal prise de notes"		12600	45.0	3.5	157.5	31.5	189.0	77.14390252145458)
;; )

;; (max
;; (time-to-day-in-year (date-to-time "2014-06-18 mer."))
;; (time-to-day-in-year (date-to-time "2014-10-08 mer."))
;; (time-to-day-in-year (date-to-time "2014-06-20 ven."))
;; )




;; "2014-06-18 mer." "2014-06-19 jeu."   "2014-09-08 lun.")




;; (format-time-string "%d-%m-%Y" (current-time))

;; (format-time-string "%d-%m" (days-to-time (time-to-day-in-year (date-to-time "2014-06-18 mer."))))
;; (format-time-string "%d-%m" (days-to-time (time-to-day-in-year

;; (format-time-string "%d-%m" (date-to-time "2014-06-18 mer."))



;; (mapcar (lambda(ßßßß)


;; (apply 'max (mapcar 'cadr '((1 2) (5 4))))

;; (lambda(x)
;; 	 (max x)) '(1 2 3 4))
;; (format-time-string "%d-%m" (days-to-time (- (time-to-days (current-time)) 1)))

;; (date-leap-year-p 2016)

;; 		     (min
;; 		      (time-to-day-in-year (date-to-time "2014-06-18 mer."))
;; 		      (time-to-day-in-year (date-to-time "2014-10-08 mer."))
;; 		      (time-to-day-in-year (date-to-time "2014-06-20 ven."))
;; 		      )
;; 		     )
;; 		    )
