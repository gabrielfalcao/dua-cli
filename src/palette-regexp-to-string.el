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
      (list
       'color-name (match-string    1)
       'color-tone-1 (match-string    5)
       'color-tone-2 (match-string    8)

       'hex-red (match-string   11)
       'hex-green (match-string   12)
       'hex-blue (match-string   13)

       'red (match-string   15)
       'green (match-string   16)
       'blue (match-string   17)
       'line-rs line-rs
       )
      )
    )
  )



;; 0=`         (blue (match-string 17))`
;; 1=`         `
;; 2=`(blue (match-string 17)`
;; 3=`blue`
;; 4=`(match-string 17)`
;; 5=`17`
