#|
 This file is a part of system-locale
 (c) 2018 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(asdf:defsystem system-locale
  :version "1.0.0"
  :license "Artistic"
  :author "Nicolas Hafner <shinmera@tymoon.eu>"
  :maintainer "Nicolas Hafner <shinmera@tymoon.eu>"
  :description "System locale and language discovery"
  :homepage "https://github.com/Shinmera/system-language"
  :serial T
  :components ((:file "package")
               (:file "toolkit")
               (:file "windows" :if-feature (:or :windows :win32 :win))
               (:file "locale")
               (:file "documentation"))
  :depends-on (:documentation-utils
               (:feature (:or :windows :win32 :win) :cffi)))
