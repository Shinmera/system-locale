#|
 This file is a part of system-locale
 (c) 2018 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.system-locale)

(cffi:defctype lpwstr :pointer)
(cffi:defctype dword :uint32)

(defconstant LOCALE_NAME_MAX_LENGTH 85)
(defconstant CP-UTF8 65001)

(cffi:defcfun (get-user-default-locale-name "GetUserDefaultLocaleName") :int
  (locale-name lpwstr)
  (chars :int))

(cffi:defcfun (get-system-default-locale-name "GetSystemDefaultLocaleName") :int
  (locale-name lpwstr)
  (chars :int))

(cffi:defcfun (wide-char-to-multi-byte "WideCharToMultiByte") :int
  (code-page :uint)
  (flags dword)
  (wide-char-str :pointer)
  (wide-char :int)
  (multi-byte-str :pointer)
  (multi-byte :int)
  (default-char :pointer)
  (used-default-char :pointer))

(defun wstring->string (pointer)
  (let ((bytes (wide-char-to-multi-byte CP-UTF8 0 pointer -1 (cffi:null-pointer) 0 (cffi:null-pointer) (cffi:null-pointer))))
    (cffi:with-foreign-object (string :uchar bytes)
      (wide-char-to-multi-byte CP-UTF8 0 pointer -1 string bytes (cffi:null-pointer) (cffi:null-pointer))
      (cffi:foreign-string-to-lisp string :encoding :utf-8))))

(defun windows-locale (&optional (kind :user))
  (cffi:with-foreign-object (buffer :uint16 LOCALE_NAME_MAX_LENGTH)
    (when (/= 0 (funcall (ecase kind
                           (:user #'get-user-default-locale-name)
                           (:system #'get-system-default-locale-name))
                         buffer LOCALE_NAME_MAX_LENGTH))
      (wstring->string buffer))))

(defun windows-locale->locale (locale)
  (let ((dash (position #\- locale)))
    (if dash
        (format NIL "~(~a~)_~:@(~a~)"
                (subseq locale 0 dash)
                (subseq locale (1+ dash)))
        locale)))
