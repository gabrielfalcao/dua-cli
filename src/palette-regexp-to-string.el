(defun palette-regexp-to-string ()
  (regexp "^\\(\\([a-z0-9[:space:]]+?\\)\\(\\(\\s-+\\)\\(light\\|medium\\|dark\\)\\)\\(\\(\\s-+\\)\\(light\\|medium\\|dark\\)\\)?\\)\\(\\s-+\\)\\([#]\\([A-F0-9]\\{2\\}\\)\\([A-F0-9]\\{2\\}\\)\\([A-F0-9]\\{2\\}\\)\\)\\(\\s-\\{6,\\}\\)\\([0-9]\\{1,3\\}\\)\\s-+\\([0-9]\\{1,3\\}\\)\\s-+\\([0-9]\\{1,3\\}\\)\\s-*$")
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
