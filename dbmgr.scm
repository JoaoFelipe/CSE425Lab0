; dbmgr.scm
; This file has the functions that parses the command line 

(include "dbfunc.scm")

; This function prints out a helpful message telling the user how to run the program
; The param should be the list of command line arguments
(define helpful-message (lambda (program-name)
	(display "Usage information:") (newline)
	(display "    ") (display program-name) (display " lookup <dat1> in <rep1>") (newline)
	(display "    ") (display program-name) (display " print <dat1> of <rep1>") (newline)
	(display "    ") (display program-name) (display " register <dat1> with <rep1>") (newline)
	(display "    ") (display program-name) (display " remove <dat1> from <rep1>") (newline)
	(display "    ") (display program-name) (display " list <rep1>") (newline)
	(display "    ") (display program-name) (display " duplicate <dat1> to <dat2> within <rep1>") (newline)
))

; This function verifies if the file with the given extension exists and if it is the expected extension
(define extension (lambda (file ext)
	(and 
		(if (and
				(> (string-length file) (string-length ext))
				(string=? (substring file (- (string-length file) (string-length ext)) (string-length file)) ext)
			) #t (begin
			(display "The file ") (display file) (display " doesn't have the expected extension") (newline)
			#f
		))
			
		(if (file-exists? file) #t (begin
			(display "The file ") (display file) (display " doesn't exist") (newline)
			#f
		))
	)
))

; This function verifies if the .dat file exists
(define dat? (lambda (file)
	(extension file ".dat")
))

; This function verifies if the .rep file exists
(define rep? (lambda (file)
	(extension file ".rep")
))


; This function parses the command-line and executes the desired function if it is well formed
; or executes the helpful-message function if it ins't
; The param should be the list of command line arguments
(define parse-command-line (lambda (line)
	(cond
		((< (length line) 3) 
			(helpful-message (car line))
		)
		((string=? (list-ref line 1) "lookup") 
			(if (and
					(= (length line) 5)				
					(dat? (list-ref line 2))
					(string=? (list-ref line 3) "in") 
					(rep? (list-ref line 4))
				) 
				(fn-lookup (list-ref line 2) (list-ref line 4)) 
				(helpful-message (car line))
			)
		)
		((string=? (list-ref line 1) "print") 
			(if (and
					(= (length line) 5)			
					(dat? (list-ref line 2))
					(string=? (list-ref line 3) "of") 
					(rep? (list-ref line 4))
				) 
				(fn-print (list-ref line 2) (list-ref line 4)) 
				(helpful-message (car line))
			)
		)
		((string=? (list-ref line 1) "register") 
			(if (and 
					(= (length line) 5)
					(dat? (list-ref line 2))
					(string=? (list-ref line 3) "with")
					(rep? (list-ref line 4))
				) 
				(fn-register (list-ref line 2) (list-ref line 4)) 
				(helpful-message (car line))
			)
		)
		((string=? (list-ref line 1) "remove") 
			(if (and 
					(= (length line) 5)
					(dat? (list-ref line 2))
					(string=? (list-ref line 3) "from") 
					(rep? (list-ref line 4))
				) 
				(fn-remove (list-ref line 2) (list-ref line 4)) 
				(helpful-message (car line))
			)
		)
		((string=? (list-ref line 1) "list") 
			(if (and
					(= (length line) 3)
					(rep? (list-ref line 2))
				)
				(fn-list (list-ref line 2)) 
				(helpful-message (car line))
			)
		)
		((string=? (list-ref line 1) "duplicate") 
			(if (and 
					(= (length line) 7)
					(dat? (list-ref line 2))
					(string=? (list-ref line 3) "to") 
					(dat? (list-ref line 4))
					(string=? (list-ref line 5) "within") 
					(rep? (list-ref line 6))
				) 
				(fn-duplicate (list-ref line 2) (list-ref line 4) (list-ref line 6)) 
				(helpful-message (car line))
			)
		)
		(else 
			(helpful-message (car line))
		)
	)
))

; Main: executes the parse-command-line function
(parse-command-line (command-line))