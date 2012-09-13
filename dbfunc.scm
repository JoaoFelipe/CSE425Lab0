; dbfunc.scm

; This function searchs for a data filename (dat) in a opened port of a repository file (rep-port)
; The repository file should be sorted
(define find-in-file (lambda (dat rep-port)  
		(let ((obj (read rep-port))) 
			(cond 
				((eof-object? obj) 
					(begin
						(close-input-port rep-port)
						#f
					)
				) 
				(else 
					(cond
						((string=? dat (symbol->string obj)) #t)
						((string<? dat (symbol->string obj)) #f)
						(else
							(find-in-file dat rep-port)
						)
					)
				)
			)
		)
))

; This function lookup for a data filename (dat) in a repository file (rep)
; The params should be the name of the files
(define fn-lookup (lambda (dat rep)
	(if (find-in-file dat (open-input-file rep))
		(display (string-append "The data file '" dat "' is listed on the repository file '" rep "'")) 
		(display (string-append "The data file '" dat "' is NOT listed on the repository file '" rep "'"))
	)
	(newline)
))

(define fn-print (lambda (dat rep)
	(display dat) (newline)
	(display rep) (newline)
))

(define fn-register (lambda (dat rep)
	(display dat) (newline)
	(display rep) (newline)
))

(define fn-remove (lambda (dat rep)
	(display dat) (newline)
	(display rep) (newline)
))

(define fn-list (lambda (rep)
	(display rep) (newline)
))

(define fn-duplicate (lambda (dat1 dat2 rep)
	(display dat1) (newline)
	(display dat2) (newline)
	(display rep) (newline)
))