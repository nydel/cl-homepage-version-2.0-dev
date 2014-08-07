(in-package :cl-homepage)

(defvar *master-port* 9913)
(defvar *master-acceptor*
  (make-instance 'easy-acceptor :port *master-port*))
(defvar *author* "nydel")
(defvar *pagetitle* "cl-homepage v2.0.1a")

(defun init () (start *master-acceptor*))
(defun kill () (stop *master-acceptor*))

(defun summon-index ()
  (define-easy-handler (homepage-index :uri "/a") ()
    (setf (content-type*) "text/html")
    (let* ((session (start-session))
	   (cookie (cookie-out "hunchentoot-session"))
	   (uname (session-value 'uname session)))
      (format nil "~a"
	      (markup:html
	       (:head
		(:title *pagetitle*)
		(:link :rel "shortcut icon" :type "image/png" :href "http://www.lispcast.com/img/lambda.png")
		(:link :rel "stylesheet" :type "text/css" :href "http://nydel.sdf.org/tem/style.css"))
	       (:body
		(:div :id "mainContainer"
		      (:div :id "topBar"
			    (:p :class "rightPadded" (markup:raw "nydel.sdf.org &rarr; version 2.0.1 alpha dev")))
		      (:div :id "banner"
			    (:img :id "banner" :src "http://nydel.sdf.org/tem/img/banner.png"))
		      (:div :id "horizontalPanel"
			    (:p :class "small" (markup:raw "&nbsp;&nbsp;&nbsp;")
				(:a :href "mailto:nydel@ma.sdf.org" "nydel") "'s home "
				(:a :href "http://sdf.org/?signup" (markup:raw "&#64;")) (markup:raw "&nbsp;")
				(:a :href "http://sdf.org/?tutorials/social_network" "sdf") (markup:raw "&nbsp;&rarr;&nbsp;" )))
		      (:hr :class "blank")
		      (:br)
		      (:div :class "titleBar"
			    (:fieldset
			     (:legend :class "title"
				      (:p :class "tiny"
					  (:b (markup:raw "&nbsp;&larr; news &or original content i think is neat | nydel's home &rarr;&nbsp;"))))
			     (format-all-entries))))))))))
