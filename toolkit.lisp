#|
 This file is a part of system-locale
 (c) 2018 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.system-locale)

(defun split (split string)
  (let ((items ()) (out (make-string-output-stream)))
    (flet ((push-item ()
             (let ((string (get-output-stream-string out)))
               (when (string/= "" string)
                 (push string items)))))
      (loop for char across string
            do (if (char= char split)
                   (push-item)
                   (write-char char out))
            finally (push-item))
      (nreverse items))))

(defun %getenv (x)
  (declare (ignorable x))
  #+(or abcl clasp clisp ecl xcl) (ext:getenv x)
  #+allegro (sys:getenv x)
  #+clozure (ccl:getenv x)
  #+cmucl (unix:unix-getenv x)
  #+scl (cdr (assoc x ext:*environment-list* :test #'string=))
  #+cormanlisp
  (let* ((buffer (ct:malloc 1))
         (cname (ct:lisp-string-to-c-string x))
         (needed-size (win:getenvironmentvariable cname buffer 0))
         (buffer1 (ct:malloc (1+ needed-size))))
    (prog1 (if (zerop (win:getenvironmentvariable cname buffer1 needed-size))
               nil
               (ct:c-string-to-lisp-string buffer1))
      (ct:free buffer)
      (ct:free buffer1)))
  #+gcl (system:getenv x)
  #+(or genera mezzano) nil
  #+lispworks (lispworks:environment-variable x)
  #+mcl (ccl:with-cstrs ((name x))
          (let ((value (_getenv name)))
            (unless (ccl:%null-ptr-p value)
              (ccl:%get-cstring value))))
  #+mkcl (#.(or (find-symbol* 'getenv :si nil) (find-symbol* 'getenv :mk-ext nil)) x)
  #+sbcl (sb-ext:posix-getenv x)
  #-(or abcl allegro clasp clisp clozure cmucl cormanlisp ecl gcl genera lispworks mcl mezzano mkcl sbcl scl xcl)
  NIL)

(defun getenv (x)
  (let ((value (%getenv x)))
    (when (string/= "" value)
      value)))

(defmacro whenlet ((var val) &body body)
  `(let ((,var ,val))
     (when ,var ,@body)))
