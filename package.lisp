(defpackage #:system-locale
  (:nicknames #:org.shirakumo.system-locale)
  (:use #:cl)
  ;; locale.lisp
  (:export
   #:*fallback-locale*
   #:*languages*
   #:*locales*
   #:locale-language
   #:locale-region
   #:locale-charset
   #:locale-equal
   #:discover-active-locales
   #:locales
   #:locale
   #:discover-active-languages
   #:languages
   #:language))

