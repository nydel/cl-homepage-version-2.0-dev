(in-package :common-lisp)

(ql:quickload '(:alexandria
		:bordeaux-threads
		:cl-daemonize
		:cl-markup
		:cl-ppcre
		:css-lite
		:drakma
		:hunchentoot
		:ironclad
		:local-time
		:sb-posix))

(defpackage :cl-homepage
  (:nicknames :homepage :home)
  (:use :common-lisp
	:alexandria
	:hunchentoot)
  (:export :init
	   :kill
	   :+summon-login+))

(in-package :cl-homepage)

(load "homepage.lisp")
(load "login.lisp")
(load "weblog.lisp")
