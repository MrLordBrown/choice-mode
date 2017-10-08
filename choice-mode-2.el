;;; choice-mode.el --- major mode for editing ChoiceScript files. -*- coding: utf-8; lexical-binding: t; mode: sws-mode -*-
;; Copyright © 2017, by Christopher R. Brown

;; Author: Christopher R. Brown ( mrlordvondoombraun@gmail.com )
;; Version: 0.0.2
;; Created: 21 AUG 2017
;; Keywords: major-mode, ChoiceScript, interactive fiction, adventure text
;; Homepage: teamawesome3.dlinkddns.com

;;; License:

;;  This file is not part of GNU Emacs. This program is free software-
;;  you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.

;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU General Public License for more details.

;;  You should have received a copy of the GNU General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;  This is a major-mode derived for writing ChoiceScript documents.

;;; Code:

(require 'sws-mode)
(visual-line-mode)

(defadvice choice-do-indent-line (around choice-indent-blank () activate)
  "Ensure proper identification of blank lines"
  (if (and (eq major-mode 'choice-mode) (sws-empty-line-p)
	   )
      (if (save-excursion
	    (previous-line)
	    (looking-at "\\(^*[a-z]*\n\\)")
	    )
	  (indent-to (sws-max-indent)
		     )
	(indent-to (sws-previous-indentation)
		   )
	)
    and-do-it)
  )

(defvar choice-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\\ "\\" table)
    (modify-syntax-entry ?\_ "\_" table)
    (modify-syntax-entry ?\' "\'" table)
    (modify-syntax-entry ?\" "\"" table)
    table)
  "syntax table for choice-mode")

(defvar choice-font-lock-keywords nil
  "set element for font-lock-defaults")

(defconst choice-font-lock-keywords
  `(
    ("\\(*\\)\\(title\\|author\\)\\(.\\)+\\(\n\\)" . font-lock-builtin-face)
    ("\\(*choice\n\\)" . 'font-lock-keyword-face)
    ("\\(*fake_choice\n\\)" . 'font-lock-keyword-face)
    ("\\(%\\)\\([-\\|+]\\)\\([0-9]+\\)" . 'font-lock-builtin-face)
    ("[\-|\+][0-9]+" . 'font-lock-builtin-face)
    ("\\($\\)\\([{\\|a-z\\|A-Z\\|0-9\\|_\\|!}]*\\)" . 'font-lock-variable-name-face)
    ("\#[^\n\r]+" . 'font-lock-type-face)
    ("\#.\n\t.*" . 'font-lock-type-face)
    ("\#.* [\\{|\\}]*" . 'font-lock-type-face)
    ("\*comment .*" . 'font-lock-comment-face)
    ("\*achievement .*" . 'font-lock-constant-face)
    ("\*create .*" . 'font-lock-variable-name-face)
    ("\*create [^\s]+" . font-lock-variable-name-face)
    ("\*set [^\s]+" . 'font-lock-variable-name-face)
    ("\*temp [^\s]+\n" . 'font-lock-variable-name-face)
    ("\*temp .*\n" . 'font-lock-variable-name-face)
    ("\*page_break" . 'font-lock-warning-face)
    ("\*if" . 'font-lock-function-name-face)
    ("\*if [\s]+ and" . 'font-lock-function-name-face)
    ("\*if .* not" . 'font-lock-function-name-face) 
    ("\*else" . 'font-lock-function-name-face)
    ("\*finish" . 'font-lock-function-name-face)
    ("\*label [a-z|A-Z]*\n" . 'font-lock-constant-face)
    ("\*label [^\s]+\n" . 'font-lock-constant-face)
    ("\*goto [a-z|A-Z|\_]*\n" . 'font-lock-constant-face)
    ("\*input_text [a-z|A-Z]*\n" . 'font-lock-builtin-face)
    ("\*[^\s]+" . font-lock-builtin-face)
    ("!" . 'font-lock-face-face)
    ("[<|>|=|!=]" . 'font-lock-variable-name-face)
    "Highlight top-level keywords")
  )

;;;###autoload
(define-derived-mode choice-mode sws-mode "ChoiceScript Mode"
  "Major mode for editing ChoiceScript files"
  (setq mode-name "ChoiceScript Mode")
  (setq font-lock-defaults
	'(
	  (choice-font-lock-keywords t))))

(provide 'choice-mode)

;;;choice-mode.el ends here
