(defun palette-regexp-to-string ()
  (save-match-data
  (let* (
         (color-name (match-string 1))
         (color-tone-1 (match-string 5))
         (color-tone-2 (match-string 8))

         (hex-red (match-string 11))
         (hex-green (match-string 12))
         (hex-blue (match-string 13))

         (red (match-string 15))
         (green (match-string 16))
         (blue (match-string 17))
         (line-rs (format "(%24s, %S, [%3d, %3d, %3d] ),"
            (format "%S" color-name)
            (format "%S" (format "#%s" (string-join (list hex-red hex-green hex-blue) "")))
            red, green, blue))
         )
    )
  )
  )
(defun palette-color-scavenge-buffer (&optional buffer-or-name)
  (interactive)
  (unless (or (bufferp buffer-or-name)
              (stringp buffer-or-name)
              (null buffer-or-name)
              )
    (signal 'error
            ))
  (erase-messages)
  (erase-c-messages)
  (c-message-open)

  (let* (
         (buf (pcase buffer-or-name

                ((pred null)
                 (current-buffer))

                ((pred bufferp)
                 buffer-or-name)

                ((and (pred stringp)
                      (let buf (get-buffer _)))
                 buf)

                (wat
                 (signal 'type-error
                         (format  "optional argument `buffer-or-name' must be either a `buffer', `string' or `nil' but instead received `%s': %s"
				  (cl-type-of buffer-or-name)
				  buffer-or-name)))
                )
              )

         (regexp
          "^\\(\\([a-z0-9[:space:]]+?\\)\\(\\(\\s-+\\)\\(light\\|medium\\|dark\\)\\)\\(\\(\\s-+\\)\\(light\\|medium\\|dark\\)\\)?\\)\\(\\s-+\\)\\([#]\\([A-F0-9]\\{2\\}\\)\\([A-F0-9]\\{2\\}\\)\\([A-F0-9]\\{2\\}\\)\\)\\(\\s-\\{6,\\}\\)\\([0-9]\\{1,3\\}\\)\\s-+\\([0-9]\\{1,3\\}\\)\\s-+\\([0-9]\\{1,3\\}\\)\\s-*$")
         (gpkeys (let* :color-name 1
                       :color-tone-1 5
                       :color-tone-2 8

                       :hex-red 11
                       :hex-green 12
                       :hex-blue 13

                       :val-red 15
                       :val-green 16
                       :val-blue 17))

         (key-pair-len (/ (length gpkeys) 2))
         (keys
          (mapcar
           (lambda (n) (nth       n   gpkeys))
           (number-sequence 0 key-pair-len 2)))
         (values (progn
                   (c-message "keys: %S" keys)
                   (mapcar (lambda (key)
                             (plist-get gpkeys key))
                           keys)
                   )
                 )

         ;; (values       (mapcar (lambda (key) (plist-get key gpkeys #'eq)) keys))

         )
    (c-message "gpkeys: %S" gpkeys)
    (c-message "keys: %S" keys)
    (c-message "values: %S" values)
    )
  )

;; (with-current-buffer buf
;;   (save-restriction
;;     (save-mark-and-excursion
;;       (widen)
;;       (beginning-of-buffer)
;;       ;; (erase-c-messages)
;;       ;; (c-message-open)
;;       (save-match-data
;;         (while (re-search-forward regexp nil t)
;;           (seq-do-indexed
;;            (lambda (key index)
;;              (let* (
;;                     (name (string-trim-left (symbol-name key) "[:]+"))
;;                     (value (plist-get gpkeys key))
;;                     )
;;                (c-message "%6s %8s key:%S %8s value:%S\n"
;;                           (format "[%d]" index)
;;                           (format "%s" (cl-type-of key)) name
;;                           (format "%s" (cl-type-of value)) value)
;;                )) ; end (lambda)
;;            keys); end seq-do-indexed
;;           ); end (let* ...)
;;         ); end (defun palette-to-string () ...)
(erase-messages)
