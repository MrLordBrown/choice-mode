;;; choice-mode.el --- major mode for editing ChoiceScript files. -*- coding: utf-8; lexical-binding: t; mode: sws-mode -*-
;; Copyright © 2017, by Christopher R. Brown

;; Author: Christopher R. Brown ( mrlordvondoombraun@gmail.com )
;; Version: 0.0.1
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
  (if (and (eq major-mode 'choice-mode) (sws-empty-line-p))
      (if (save-excursion
	    (previous-line)
	    (looking-at "^\*[a-z]*\n"))
	  (indent-to (sws-max-indent))
	(indent-to (sws-previous-indentation)))
    ad-do-it))

(defvar choice-font-lock-keywords nil
  "set element for font-lock-defaults")

(defconst choice-font-lock-keywords
  `(
    ("[<|>|=|!=]" . font-lock-variable-name-face)
    ("\*title [^\n\r]*\n" . 'font-lock-type-face)
    ("\*author [^\n\r]*\n" . 'font-lock-type-face)
    ("\*scene_list\n" . 'font-lock-type-face)
    ("\*choice\n" . font-lock-keyword-face)
    ("\*fake_choice\n" . font-lock-keyword-face)
    ("\*comment .*" . font-lock-comment-face)
    ("\*create .*". font-lock-variable-name-face)
    ("\*set .*". font-lock-variable-name-face)
    ("\*temp .*" . font-lock-variable-name-face)
    ("\$[\{|\\a-z|\\0-9|\\_|\}]*" . font-lock-variable-name-face)
    ("\*page_break\n" . font-lock-warning-face)
    ("\*if" . font-lock-function-name-face)
    ("\*else" . font-lock-function-name-face)
    ("\*finish" . font-lock-function-name-face)
    ("\*label [a-z|A-Z]*\n" . font-lock-constant-face)
    ("\*goto [a-z|A-Z]*\n" . font-lock-constant-face)
    ("\*input_text [a-z|A-Z]*\n" . font-lock-builtin-face)
    "Highlight top-level keywords"))

;;;###autoload
(define-derived-mode choice-mode sws-mode "ChoiceScript Mode"
  "Major mode for editing ChoiceScript files"
  (setq mode-name "ChoiceScript Mode")
  (setq font-lock-defaults
	'(
	  (choice-font-lock-keywords)))
  )

(provide 'choice-mode)

;;;choice-mode.el ends here
