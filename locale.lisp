(in-package #:org.shirakumo.system-locale)

(defvar *fallback-locale* "en_US.UTF-8")
(defvar *locales*)
(defvar *languages*)

(defun locale-language (locale)
  (let ((pos (or (position #\_ locale)
                 (position #\. locale))))
    (string-downcase
     (cond ((null pos)
            locale)
           ((= 0 pos)
            NIL)
           (T
            (subseq locale 0 pos))))))

(defun locale-region (locale)
  (let ((under (position #\_ locale)))
    (when under
      (string-upcase
       (subseq locale (1+ under) (position #\. locale))))))

(defun locale-charset (locale)
  (let ((pos (position #\. locale)))
    (when pos
      (string-upcase
       (subseq locale (1+ pos))))))

(defun locale-equal (a b)
  (flet ((same (prop)
           (let ((a (funcall prop a))
                 (b (funcall prop b)))
             (or (not a) (not b) (string-equal a b)))))
    (and (same #'locale-language)
         (same #'locale-region)
         (same #'locale-charset))))

(defun discover-active-locales ()
  (let ((locales ()))
    (flet ((add (locale)
             (pushnew locale locales :test #'string-equal)))
      (whenlet (locale (getenv "LC_ALL"))
        (add locale))
      (whenlet (locale (getenv "LC_MESSAGES"))
        (add locale))
      (whenlet (locale (getenv "LANG"))
        (add locale))
      #+windows
      (whenlet (locale (windows-locale :user))
        (add (windows-locale->locale locale)))
      #+windows
      (whenlet (locale (windows-locale :system))
        (add (windows-locale->locale locale)))
      (nreverse locales))))

(defun locales (&key rediscover)
  (if (or (not (boundp '*locales*)) rediscover)
      (setf *locales* (discover-active-locales))
      *locales*))

(defun (setf locales) (locales)
  (setf *locales* locales))

(defun locale (&rest supported)
  (or (loop for locale in (locales)
            do (when (or (not supported)
                         (find locale supported :test #'locale-equal))
                 (return locale)))
      (values *fallback-locale*
              :fallback)))

(defun (setf locale) (locale)
  (setf *locales* (list* locale (remove locale *locales* :test #'string-equal))))

(defun discover-active-languages ()
  (remove-duplicates
   (append (whenlet (a (getenv "LANGUAGE")) (split #\: a))
           #+nx (cffi:foreign-funcall "nxgl_language" :string)
           (mapcar #'locale-language (discover-active-locales)))
   :test #'string-equal))

(defun languages (&key rediscover)
  (if (or (not (boundp '*languages*)) rediscover)
      (setf *languages* (discover-active-languages))
      *languages*))

(defun (setf languages) (languages)
  (setf *languages* languages))

(defun language (&rest supported)
  (or (loop for lang in (languages)
            thereis (find lang supported :test #'string-equal))
      (values (locale-language *fallback-locale*)
              :fallback)))

(defun (setf language) (language)
  (setf *languages* (list* language (remove language *languages* :test #'string-equal))))
