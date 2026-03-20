;0=`aluminum dark dark      #2E3436       46  52  54`
;1=`aluminum dark dark`
;2=`aluminum`
;3=` dark`
;4=` `
;5=`dark`
;6=` dark`
;7=` `
;8=`dark`
;9=`      `
;10=`#2E3436`
;11=`2E`
;12=`34`
;13=`36`
;14=`       `
;15=`46`
;16=`52`
;17=`54`
;
; ^\(\([a-z0-9[:space:]]+?\)\(\(\s-+\)\(light\|medium\|dark\)\)\(\(\s-+\)\(light\|medium\|dark\)\)?\)\(\s-+\)\([#]\([A-F0-9]\{2\}\)\([A-F0-9]\{2\}\)\([A-F0-9]\{2\}\)\)\(\s-\{6,\}\)\([0-9]\{1,3\}\)\s-+\([0-9]\{1,3\}\)\s-+\([0-9]\{1,3\}\)\s-*$ → \,(regex!)

(let* (
       (haystack (string-join (list "aluminum dark dark      #2E3436       46  52  54"
                                    "yellow light            #FCE94F      252 233  79")
                              "\n"))
       (regexp "^\\(\\([a-z0-9[:space:]]+?\\)\\(\\(\\s-+\\)\\(light\\|medium\\|dark\\)\\)\\(\\(\\s-+\\)\\(light\\|medium\\|dark\\)\\)?\\)\\(\\s-+\\)\\([#]\\([A-F0-9]\\{2\\}\\)\\([A-F0-9]\\{2\\}\\)\\([A-F0-9]\\{2\\}\\)\\)\\(\\s-\\{6,\\}\\)\\([0-9]\\{1,3\\}\\)\\s-+\\([0-9]\\{1,3\\}\\)\\s-+\\([0-9]\\{1,3\\}\\)\\s-*$")
       (gpkeys (list :color-name 1
                     :color-tone-1 5
                     :color-tone-2 8

                     :hex-red 11
                     :hex-green 12
                     :hex-blue 13

                     :val-red 15
                     :val-green 16
                     :val-blue 17))
       (key-pair-len (/ (length gpkeys) 2))
       (keys         (mapcar (lambda (n)   (nth       n   gpkeys)) (number-sequence 0 key-pair-len 2)))
       ;; (values       (mapcar (lambda (key) (plist-get key gpkeys #'eq)) keys))
       )
  (erase-c-messages)
  (c-message-open)
  (seq-do-indexed (lambda (sym index)
                    (let* (
                           (key (symbol-name sym))
                           (name (string-trim-left key "[:]+"))
                           (value (plist-get gpkeys key #'eq))
                           )
                      )
                    )
                  keys)
  )
)
