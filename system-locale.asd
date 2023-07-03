(asdf:defsystem system-locale
  :version "1.0.0"
  :license "zlib"
  :author "Yukari Hafner <shinmera@tymoon.eu>"
  :maintainer "Yukari Hafner <shinmera@tymoon.eu>"
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
