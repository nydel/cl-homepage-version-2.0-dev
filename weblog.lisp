(in-package :cl-homepage)

(defstruct entry timestamp user title content)

(defvar *log-entry-db-path* "data/.weblog.db")

(defvar *db-log-entries* '())

(defun write-entries ()
  (with-open-file (@db *log-entry-db-path*
		       :direction :output
		       :if-exists :rename
		       :if-does-not-exist :create)
    (when *db-log-entries*
      (format @db "~{~a~&~}"
	      (mapcar #'(lambda (y)
			  (write-to-string y))
		      *db-log-entries*)))))

(defun &add-entry (&key timestamp user title content)
  (make-entry :timestamp (if timestamp timestamp (get-universal-time))
	      :user (if user user "localhost")
	      :title (if title title "(no subject)")
	      :content content))

(defun add-entry (&key timestamp user title content)
  (push
   (&add-entry :timestamp timestamp
	       :user user
	       :title title
	       :content content)
   *db-log-entries*)
  (write-entries))

(defun &load-log-entries ()
  (with-open-file (@db *log-entry-db-path*
		       :direction :input
		       :if-does-not-exist :create)
    (loop for entry = (read @db nil 'eof)
	 until (equal entry 'eof)
	 collect entry)))

(defun load-log-entries ()
  (setf *db-log-entries* (&load-log-entries)))

(defun format-entry-for-log (entry)
  (markup:markup
   (:dl
    (:dt :style "font-weight: bold; font-size: 12px; padding: 0; margin: 0; margin-left: 1%; margin-right: 15%;" (markup:raw (entry-title entry)))
    (:dt :style "font-weight: bold; font-size: 10px; padding: 0; margin: 0; margin-left: 1%; margin-right: 15%;" (write-to-string (entry-timestamp entry)) " by " (entry-user entry))
    (:dd :style "padding: 0; margin: 0; margin-left: 5%; margin-right: 15%;" (entry-content entry)))
   (:hr :class "blank")))

(defun format-all-entries ()
  (mapcar
   #'(lambda (y)
       (format-entry-for-log y))
   *db-log-entries*))
