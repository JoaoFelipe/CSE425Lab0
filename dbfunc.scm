; dbfunc.scm

(include "dbfileutils.scm")

; This function lookup for a data filename (dat) in a repository file (rep)
; The params should be the name of the files
; Command-line usage: ./dbmgr lookup <dat> in <rep>
(define fn-lookup (lambda (dat rep)
	(if (find-in-file dat (open-input-file rep))
		(display (string-append "The data file '" dat "' is listed on the repository file '" rep "'")) 
		(display (string-append "The data file '" dat "' is NOT listed on the repository file '" rep "'"))
	)
	(newline)
))

; This function lookup for a data filename (dat) in a repository file (rep)
; If the data file exists in the repository file, a verbatim listing of the data file is displayed
; The params should be the name of the files
; Command-line usage: ./dbmgr print <dat> of <rep>
(define fn-print (lambda (dat rep)
	(if (find-in-file dat (open-input-file rep))
		(print-file (open-input-file dat))
		(display (string-append "The data file '" dat "' is NOT listed on the repository file '" rep "'"))
	)
	(newline)
))

; This function lookup for a data filename (dat) in a repository file (rep)
; If the data file doesn't exist in the repository file, the data file will be registred on the repository file
; The params should be the name of the files
; Command-line usage: ./dbmgr register <dat> with <rep>
(define fn-register (lambda (dat rep)
	(if (find-in-file dat (open-input-file rep))
		(display (string-append "The data file '" dat "' is ALREADY listed on the repository file '" rep "'"))
		(begin
			(rename-file rep (string-append "temp" rep))
			(add-to-file (open-input-file (string-append "temp" rep)) (open-output-file rep) dat #f)
			(delete-file (string-append "temp" rep))
			(display (string-append "The data file '" dat "' was added to the repository file '" rep "'"))
		)
	)
	(newline)
))

; This function lookup for a data filename (dat) in a repository file (rep)
; If the data file exists in the repository file, the data file will be removed from the repository file
; The params should be the name of the files
; Command-line usage: ./dbmgr remove <dat> from <rep>
(define fn-remove (lambda (dat rep)
	(if (find-in-file dat (open-input-file rep))
		(begin
			(rename-file rep (string-append "temp" rep))
			(remove-from-file (open-input-file (string-append "temp" rep)) (open-output-file rep) dat)
			(delete-file (string-append "temp" rep))
			(display (string-append "The data file '" dat "' was removed from the repository file '" rep "'"))
		)
		(display (string-append "The data file '" dat "' is NOT listed on the repository file '" rep "'"))
		
	)
	(newline)
))

(define fn-list (lambda (rep)
	(print-file (open-input-file rep))
	(newline)
))

(define fn-duplicate (lambda (dat1 dat2 rep)
	(display dat1) (newline)
	(display dat2) (newline)
	(display rep) (newline)
))