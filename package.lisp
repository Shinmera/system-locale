#|
 This file is a part of system-locale
 (c) 2018 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

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

