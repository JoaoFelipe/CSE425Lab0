; This function searchs for a data filename (dat) in a opened port of a repository file (rep-port)
; The repository file should be sorted
(define find-in-file (lambda (dat rep-port)  
	(let ((obj (read rep-port))) 
		(cond 
			((or (eof-object? obj) (string<? dat (symbol->string obj))) (begin
				(close-input-port rep-port)
				#f
			)) 
			((string=? dat (symbol->string obj)) (begin 
				(close-input-port rep-port) 
				#t
			))
			(else 
				(find-in-file dat rep-port)
			)
		)
	)
))

; This function prints out all the contents of a file opened in a port
(define print-file (lambda (port)  
	(let ((obj (read-char port))) 
		(cond 
			((eof-object? obj)
				(close-input-port port)
			) 
			(else 
				(display obj)
				(print-file port)
			)
		)
	)
))

; This function adds a word to a sorted file opened in a port(port-read) 
; and copies the file to another opened port (port-add)
(define add-to-file (lambda (port-read port-write word added)  
	(let ((obj (read port-read))) 
		(cond 
			((and (eof-object? obj) (not added)) (begin 
				(display word port-write)
				(close-output-port port-write) 
				(close-input-port port-read)
			))
			((and (eof-object? obj) added) (begin 
				(close-output-port port-write) 
				(close-input-port port-read)
			)) 			
			((and (string<? word (symbol->string obj)) (not added))(begin 
				(display word port-write)
				(display "\n" port-write)
				(display obj port-write)
				(display "\n" port-write)
				(add-to-file port-read port-write word #t)
			))
			(else 
				(display obj port-write)
				(display "\n" port-write)
				(add-to-file port-read port-write word added)
			)
		)
	)
))

; This function removes a word to a sorted file opened in a port(port-read) 
; and copies the file to another opened port (port-add)
(define remove-from-file (lambda (port-read port-write word)  
	(let ((obj (read port-read))) 
		(cond 
			((eof-object? obj) (begin 
				(close-output-port port-write) 
				(close-input-port port-read)
			)) 			
			((string=? word (symbol->string obj))(begin 
				(remove-from-file port-read port-write word)
			))
			(else 
				(display obj port-write)
				(display "\n" port-write)
				(remove-from-file port-read port-write word)
			)
		)
	)
))