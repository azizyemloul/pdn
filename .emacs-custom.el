(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-modes (quote (tex-mode plain-tex-mode latex-mode doctex-mode)))
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(auto-insert-alist
   (quote
    ((("\\.\\([Hh]\\|hh\\|hpp\\)\\'" . "C / C++ header")
      (upcase
       (concat
	(file-name-nondirectory
	 (file-name-sans-extension buffer-file-name))
	"_"
	(file-name-extension buffer-file-name)))
      "#ifndef " str n "#define " str "

" _ "

#endif")
     (("\\.\\([Cc]\\|cc\\|cpp\\)\\'" . "C / C++ program")
      nil "#include \""
      (let
	  ((stem
	    (file-name-sans-extension buffer-file-name)))
	(cond
	 ((file-exists-p
	   (concat stem ".h"))
	  (file-name-nondirectory
	   (concat stem ".h")))
	 ((file-exists-p
	   (concat stem ".hh"))
	  (file-name-nondirectory
	   (concat stem ".hh")))))
      & 34 | -10)
     (("[Mm]akefile\\'" . "Makefile")
      . "makefile.inc")
     (html-mode lambda nil
		(sgml-tag "html"))
     (plain-tex-mode . "tex-insert.tex")
     (bibtex-mode . "tex-insert.tex")
     (org-mode . "org-insert.org")
     (latex-mode "options, RET: " "\\documentclass[" str & 93 | -1 123
		 (read-string "class: ")
		 "}
"
		 ("package, %s: " "\\usepackage["
		  (read-string "options, RET: ")
		  & 93 | -1 123 str "}
")
		 _ "
\\begin{document}
" _ "
\\end{document}")
     (("/bin/.*[^/]\\'" . "Shell-Script mode magic number")
      lambda nil
      (if
	  (eq major-mode
	      (default-value
		(quote major-mode)))
	  (sh-mode)))
     (ada-mode . ada-header)
     (("\\.[1-9]\\'" . "Man page skeleton")
      "Short description: " ".\\\" Copyright (C), "
      (substring
       (current-time-string)
       -4)
      "  "
      (getenv "ORGANIZATION")
      |
      (progn user-full-name)
      "
.\\\" You may distribute this file under the terms of the GNU Free
.\\\" Documentation License.
.TH "
      (file-name-sans-extension
       (file-name-nondirectory
	(buffer-file-name)))
      " "
      (file-name-extension
       (buffer-file-name))
      " "
      (format-time-string "%Y-%m-%d ")
      "
.SH NAME
"
      (file-name-sans-extension
       (file-name-nondirectory
	(buffer-file-name)))
      " \\- " str "
.SH SYNOPSIS
.B "
      (file-name-sans-extension
       (file-name-nondirectory
	(buffer-file-name)))
      "
" _ "
.SH DESCRIPTION
.SH OPTIONS
.SH FILES
.SH \"SEE ALSO\"
.SH BUGS
.SH AUTHOR
"
      (user-full-name)
      (quote
       (if
	   (search-backward "&"
			    (line-beginning-position)
			    t)
	   (replace-match
	    (capitalize
	     (user-login-name))
	    t t)))
      (quote
       (end-of-line 1))
      " <"
      (progn user-mail-address)
      ">
")
     (("\\.el\\'" . "Emacs Lisp header")
      "Short description: " ";;; "
      (file-name-nondirectory
       (buffer-file-name))
      " --- " str "

;; Copyright (C) "
      (substring
       (current-time-string)
       -4)
      "  "
      (getenv "ORGANIZATION")
      |
      (progn user-full-name)
      "

;; Author: "
      (user-full-name)
      (quote
       (if
	   (search-backward "&"
			    (line-beginning-position)
			    t)
	   (replace-match
	    (capitalize
	     (user-login-name))
	    t t)))
      (quote
       (end-of-line 1))
      " <"
      (progn user-mail-address)
      ">
;; Keywords: "
      (quote
       (require
	(quote finder)))
      (quote
       (setq v1
	     (mapcar
	      (lambda
		(x)
		(list
		 (symbol-name
		  (car x))))
	      finder-known-keywords)
	     v2
	     (mapconcat
	      (lambda
		(x)
		(format "%12s:  %s"
			(car x)
			(cdr x)))
	      finder-known-keywords "
")))
      ((let
	   ((minibuffer-help-form v2))
	 (completing-read "Keyword, C-h: " v1 nil t))
       str ", ")
      & -2 "

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; " _ "

;;; Code:



(provide '"
      (file-name-sans-extension
       (file-name-nondirectory
	(buffer-file-name)))
      ")
;;; "
      (file-name-nondirectory
       (buffer-file-name))
      " ends here
")
     (("\\.texi\\(nfo\\)?\\'" . "Texinfo file skeleton")
      "Title: " "\\input texinfo   @c -*-texinfo-*-
@c %**start of header
@setfilename "
      (file-name-sans-extension
       (file-name-nondirectory
	(buffer-file-name)))
      ".info
" "@settitle " str "
@c %**end of header
@copying
"
      (setq short-description
	    (read-string "Short description: "))
      ".

" "Copyright @copyright{} "
      (substring
       (current-time-string)
       -4)
      "  "
      (getenv "ORGANIZATION")
      |
      (progn user-full-name)
      "

@quotation
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
A copy of the license is included in the section entitled ``GNU
Free Documentation License''.

A copy of the license is also available from the Free Software
Foundation Web site at @url{http://www.gnu.org/licenses/fdl.html}.

@end quotation

The document was typeset with
@uref{http://www.texinfo.org/, GNU Texinfo}.

@end copying

@titlepage
@title " str "
@subtitle " short-description "
@author "
      (getenv "ORGANIZATION")
      |
      (progn user-full-name)
      " <"
      (progn user-mail-address)
      ">
@page
@vskip 0pt plus 1filll
@insertcopying
@end titlepage

@c Output the table of the contents at the beginning.
@contents

@ifnottex
@node Top
@top " str "

@insertcopying
@end ifnottex

@c Generate the nodes for this menu with `C-c C-u C-m'.
@menu
@end menu

@c Update all node entries with `C-c C-u C-n'.
@c Insert new nodes with `C-c C-c n'.
@node Chapter One
@chapter Chapter One

" _ "

@node Copying This Manual
@appendix Copying This Manual

@menu
* GNU Free Documentation License::  License for copying this manual.
@end menu

@c Get fdl.texi from http://www.gnu.org/licenses/fdl.html
@include fdl.texi

@node Index
@unnumbered Index

@printindex cp

@bye

@c "
      (file-name-nondirectory
       (buffer-file-name))
      " ends here
"))))
 '(auto-insert-directory "~/.emacs.d/insert/")
 '(battery-mode-line-format "[battery %b%p%%]")
 '(battery-status-function (quote battery-linux-sysfs))
 '(bhl-end-toc "--- Fin de la table de contenus")
'(bhl-html-content-type
"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf8\">")
 '(bhl-i18n-conventions (quote ("fr" t t t)))
 '(bhl-intro-toc "--- Table de contenus")
 '(bhl-sectioning-default-style (quote aster))
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(bookmark-default-file "~/.emacs.d/emacs.bmk")
 '(bookmark-save-flag 1)
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "chrome")
 '(cal-html-print-day-number-flag t)
'(calendar-day-name-array
["Dimanche" "Lundi" "Mardi" "Merecredi" "Jeudi" "Vendredi" "Samedi"])
'(calendar-month-name-array
["Janvier" "Fevrier" "Mars" "Avril" "Mai" "Juin" "Juillet" "Août" "Septembre" "Octobre" "Novembre" "Decembre"])
 '(calendar-view-diary-initially-flag t)
 '(calendar-week-start-day 0)
 '(canlock-password "52e7bac027ec114b9038f9b841466e12a984aea4")
 '(case-fold-search nil)
 '(column-number-mode t)
 '(comment-multi-line t)
 '(csv-separators (quote ("	")))
'(custom-safe-themes
(quote
 ("9f6750057fefba39c184783c7b80ddd9c63bc6e8064846b423b4362c9e930404" "fbcdb6b7890d0ec1708fa21ab08eb0cc16a8b7611bb6517b722eba3891dfc9dd" "8e7ca85479dab486e15e0119f2948ba7ffcaa0ef161b3facb8103fb06f93b428" "0ec59d997a305e938d9ec8f63263a8fc12e17990aafc36ff3aff9bc5c5a202f0" "6ffef0161169e444b514a0f7f0cb7eac09d11c396cdc99bf85360a361c427886" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "e8a9dfa28c7c3ae126152210e3ccc3707eedae55bdc4b6d3e1bb3a85dfb4e670" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "c006bc787154c31d5c75e93a54657b4421e0b1a62516644bd25d954239bc9933" "ad24ea739f229477ea348af968634cb7a0748c9015110a777c8effeddfa920f5" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(dabbrev-ignored-buffer-names (quote ("*Buffer List*")))
 '(delete-by-moving-to-trash nil)
 '(desktop-path (quote ("~/.emacs.d/desktops")))
 '(desktop-restore-forces-onscreen nil)
 '(desktop-restore-frames nil)
 '(desktop-save t)
 '(dictionary-server "localhost")
 '(dired-bind-jump t)
 '(dired-listing-switches "-alh --group-directories-first")
 '(display-battery-mode nil)
 '(display-time-format "[date: %a %d %b %H:%M]")
 '(display-time-mode t)
 '(ecb-options-version "2.32")
 '(ecb-source-path (quote (("/home/aziz/org/archive/2012-07/org" "org"))))
 '(ecb-use-speedbar-instead-native-tree-buffer t)
 '(ecb-windows-width 0 t)
 '(european-calendar-style t)
 '(flyspell-abbrev-p t)
 '(flyspell-default-dictionary "francais")
 '(flyspell-sort-corrections nil)
 '(gnus-site-init-file "~/.gnus.el")
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "fr")
 '(help-window-select t)
 '(history-length t)
 '(ido-enable-flex-matching t)
 '(ido-ignore-buffers (quote ("\\` " "\\*helm")))
 '(ido-show-dot-for-dired t)
 '(inferior-lisp-program "clisp" t)
 '(inhibit-default-init t)
 '(inhibit-startup-screen t)
 '(ispell-default-dictionary "francais")
 '(ispell-highlight-face (quote flyspell-incorrect))
 '(ispell-keep-choices-win t)
 '(ispell-local-dictionary "francais")
 '(ispell-silently-savep t)
 '(iswitchb-mode nil)
 '(jde-compiler (quote ("javac server" "/usr/lib/jvm/jdk1.7.0/bin/javac")))
 '(jde-jdk-registry (quote (("1.6.0" . "/usr/lib/jvm/jdk1.7.0"))))
 '(jdee-server-dir "~/workspace/Assignment1/")
 '(langtool-default-language "fr")
 '(list-directory-brief-switches "--group-directories-first -CFh")
 '(list-directory-verbose-switches "--group-directories-first -lh")
 '(mail-abbrevs-mode t)
 '(mail-abbrevs-only t)
 '(mail-user-agent (quote gnus-user-agent))
 '(menu-bar-mode nil)
 '(message-directory "~/.mails/")
 '(mls-cpu-format "%A %C0 %C1")
 '(mls-disk-format "%p")
 '(mls-memory-format "%R %R %S %R")
 '(org-agenda-columns-add-appointments-to-effort-sum t)
 ;; '(org-agenda-diary-file "~/org/diary.org")
 ;; '(org-agenda-files (quote ("~/org/diary.org")))
 '(org-agenda-insert-diary-strategy (quote top-level))
 '(org-agenda-menu-two-columns t)
 '(org-agenda-property-list (quote ("lieux")))
 '(org-agenda-start-on-weekday nil)
'(org-agenda-time-grid
(quote
 ((daily weekly today require-timed)
  #("----------------" 0 16
    (org-heading t))
  (700 1200 1700 2300))))
 '(org-agenda-timegrid-use-ampm nil)
 '(org-agenda-window-setup (quote other-window))
 '(org-archive-location "~/org/archive.org::* Depuis %s")
 '(org-attach-method (quote mv))
 '(org-attach-store-link-p (quote attached))
'(org-babel-load-languages
(quote
 ((emacs-lisp . t)
  (sh . t)
  (sql . t)
  (awk . t)
  (C . t)
  (python . t))))
'(org-capture-templates
(quote
 (("w" "Default template" entry
   (file+headline "~/org/capture.org" "Notes")
   "* %^{Title}

  Source: %u, %c

  %i" :empty-lines 1))) t)
 '(org-clock-clocktable-default-properties (quote (:maxlevel 2 :scope file)))
 '(org-clock-into-drawer "LOGBOOK")
 '(org-clock-string-limit 5)
 '(org-confirm-elisp-link-function nil)
 '(org-confirm-shell-link-function (quote y-or-n-p))
 '(org-cycle-include-plain-lists (quote integrate))
 '(org-deadline-warning-days 30)
 '(org-default-notes-file "~/org/notes.org")
 '(org-docbook-xsl-fo-proc-command "fop %i %o")
 '(org-docbook-xslt-proc-command "xsltproc --output %o %s %i")
'(org-docbook-xslt-stylesheet
"/usr/share/sgml/docbook/stylesheet/xsl/docbook-xsl/fo/docbook.xsl")
 '(org-edit-timestamp-down-means-later t)
 '(org-ellipsis "…")
'(org-emphasis-alist
(quote
 (("*" org-todo "<b>" "</b>")
  ("/" italic "<i>" "</i>")
  ("_" underline "<span style=\"text-decoration:underline;\">" "</span>")
  ("=" org-code "<code>" "</code>" verbatim)
  ("~" org-verbatim "<code>" "</code>" verbatim)
  ("+"
   (:strike-through t)
   "<del>" "</del>"))))
 '(org-enforce-todo-dependencies t)
 '(org-export-date-timestamp-format "%d-%m-%Y")
 '(org-footnote-define-inline nil)
 '(org-footnote-section "Renvois")
'(org-html-head
"<link rel=\"stylesheet\" type=\"text/css\" href=\"./css/stylesheet.css\">")
 '(org-html-head-include-default-style t)
 '(org-html-postamble-format (quote (("fr" "<p class=\"author\">%a (%e) %T</p>"))))
'(org-html-style
"<link rel=\"stylesheet\" type=\"text/css\" href=\"./css/stylesheet.css\">")
 '(org-html-style-include-default t)
 '(org-html-with-timestamp t t)
 '(org-insert-labeled-timestamps-at-point t)
'(org-latex-default-packages-alist
(quote
 (("AUTO" "inputenc" t)
  ("T1" "fontenc" t)
  ("" "fixltx2e" nil)
  ("" "graphicx" t)
  ("" "longtable" t)
  ("" "float" nil)
  ("" "wrapfig" nil)
  ("" "soul" t)
  ("" "t1enc" t)
  ("" "textcomp" t)
  ("" "marvosym" t)
  ("" "wasysym" t)
  ("" "latexsym" t)
  ("" "amssymb" t)
  ("" "hyperref" nil)
  "\\tolerance=1000"
  ("" "xcolor" t)
  ("" "geometry" nil))))
 '(org-latex-tables-column-borders t)
; '(org-mobile-files (quote ("~/org/diary.org")))
'(org-modules
(quote
 (org-protocol org-bbdb org-gnus org-w3m org-toc org-jsinfo)))
 '(org-odt-convert-process "unoconv")
'(org-odt-convert-processes
(quote
 (("LibreOffice" "soffice --headless --convert-to %f%x --outdir %d %i")
  ("unoconv" "unoconv -f %f %i"))))
 '(org-odt-preferred-output-format "doc")
 '(org-odt-styles-file "~/.emacs.d/org-templates/style.odt")
 '(org-read-date-popup-calendar t)
 '(org-refile-active-region-within-subtree t)
 '(org-refile-allow-creating-parent-nodes (quote confirm))
 '(org-refile-use-cache t)
 '(org-refile-use-outline-path t)
 '(org-scheduled-string "SCHEDULED:")
 '(org-src-preserve-indentation t)
 '(org-src-window-setup (quote current-window))
 '(org-startup-folded (quote content))
 '(org-support-shift-select t)
 '(org-time-stamp-custom-formats (quote ("<%a %d-%m-%y>" . "<%a %d-%m-%y %H:%M>")))
 '(org-toc-follow-mode t)
 '(org-use-property-inheritance t)
 '(org-use-tag-inheritance nil)
'(org2blog/wp-buffer-template
"#+DATE: %s
#+OPTIONS: toc:nil num:nil todo:t pri:nil tags:t ^:t TeX:nil
#+CATEGORY: %s
#+TAGS:
#+DESCRIPTION:
#+TITLE: %s

")
 '(org2blog/wp-default-categories (quote ("Sténo" "Autre")))
 '(org2blog/wp-default-title "Sujet")
 '(org2blog/wp-keep-new-lines t)
 '(org2blog/wp-show-post-in-browser t)
'(package-archives
(quote
 (("gnu" . "http://elpa.gnu.org/packages/")
  ("marmalade" . "http://marmalade-repo.org/packages/")
  ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(read-mail-command (quote gnus))
'(safe-local-variable-values
(quote
 ((eval setq org-html-head-include-default-style t org-html-head-include-scripts
	(quote nil)))))
 '(scheme-program-name "guile")
 '(scroll-down-aggressively nil)
 '(scroll-up-aggressively nil)
 '(sentence-end "[.?!][]\\\"')}]*\\\\($\\\\|\\t)[\\t\\n]*")
 '(sentence-end-double-space nil)
 '(show-paren-style (quote expression))
 '(show-trailing-whitespace t)
 '(size-indication-mode t)
 '(speedbar-default-position (quote left-right))
 '(speedbar-query-confirmation-method (quote none-but-delete))
 '(speedbar-show-unknown-files t)
 '(speedbar-tag-hierarchy-method (quote (speedbar-simple-group-tag-hierarchy)))
 '(split-width-threshold 200)
 '(split-window-preferred-function (quote split-window-sensibly))
 '(sr-speedbar-width-console 27)
 '(sr-speedbar-width-x 45)
 '(tabbar-separator (quote ("|_|")))
'(term-bind-key-alist
(quote
 (("C-c C-c" . term-interrupt-subjob)
  ("C-p" . previous-line)
  ("C-n" . next-line)
  ("C-s" . isearch-forward)
  ("C-r" . isearch-backward)
  ("C-m" . term-send-raw)
  ("M-f" . term-send-forward-word)
  ("M-b" . term-send-backward-word)
  ("M-o" . term-send-backspace)
  ("M-p" . term-send-up)
  ("M-n" . term-send-down)
  ("M-M" . term-send-forward-kill-word)
  ("M-N" . term-send-backward-kill-word)
  ("M-r" . term-send-reverse-search-history)
  ("M-," . term-send-input)
  ("M-." . comint-dynamic-complete)
  ("C-o" . other-window))))
 '(tool-bar-mode nil)
'(tramp-remote-process-environment
(quote
 ("HISTFILE=$HOME/.tramp_history" "HISTSIZE=1" "LC_ALL=fr_FR.UTF-8" "TERM=dumb" "EMACS=t" "INSIDE_EMACS='24.3.1,tramp:2.2.6-24.3'" "CDPATH=" "HISTORY=" "MAIL=" "MAILCHECK=" "MAILPATH=" "PAGER=\"\"" "autocorrect=" "correct=")))
 '(uce-mail-reader (quote gnus))
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(visible-bell t)
'(w3m-antenna-sites
(quote
 (("http://tychoish.com/" "tychoish – Visits, Modes, and Forms — tychoish" nil)
  ("https://github.com/ch11ng/exwm/wiki" "Home · ch11ng/exwm Wiki · GitHub" nil))))
 '(w3m-cookie-accept-bad-cookies t)
 '(w3m-default-display-inline-images nil)
 '(w3m-home-page "http://localhost")
 '(w3m-key-binding (quote info))
 '(w3m-mailto-url-function nil)
 '(w3m-use-cookies t)
 '(wdired-allow-to-change-permissions (quote advanced))
 '(window-min-height 1))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diredp-dir-heading ((t (:background "Pink" :foreground "yellow"))))
 '(flyspell-duplicate ((t (:background "black" :foreground "green" :underline t :weight bold))))
 '(flyspell-incorrect ((t (:foreground "red" :underline t))))
 '(gnus-cite-1 ((t (:foreground "cyan"))))
 '(gnus-summary-normal-ancient ((t (:foreground "orange red" :weight normal))))
 '(gnus-summary-normal-unread ((t (:foreground "dim gray" :weight normal))))
 '(highlight ((t (:background "cyan"))))
 '(message-header-cc ((t (:foreground "brightgreen"))))
 '(message-header-subject ((t (:foreground "brightgreen" :weight bold))))
 '(message-header-to ((t (:foreground "brightgreen" :weight bold))))
 '(org-footnote ((t (:foreground "red" :underline t))))
 '(org-level-1 ((t (:inherit outline-1 :foreground "blue" :weight normal))))
 '(org-level-2 ((t (:inherit outline-2 :weight bold))))
 '(org-level-3 ((t (:inherit outline-3 :foreground "brightred"))))
 '(org-level-4 ((t (:inherit outline-4 :foreground "magenta"))))
 '(org-level-5 ((t (:inherit outline-5 :foreground "yellow"))))
 '(org-link ((t (:inherit link :foreground "cyan" :slant oblique)))))
