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

; This function prints out all the contents of a file opened in a port
(define print-file (lambda (port)  
		(let ((obj (read-char port))) 
			(cond 
				(
					(eof-object? obj) (close-input-port port)
				) 
				(else (display obj)
			      		(print-file port)
				)
			)
		)
	) 
)