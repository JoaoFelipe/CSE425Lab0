; dbfunc.scm
; Amanda Priscilla Araujo da Silva
; Joao Felipe Nicolaci Pimentel
; This file contains the main features of the program

(include "dbfileutils.scm")

; This function lookup for a data filename (dat) in a repository file (rep)
; The params should be the name of the files
; Command-line usage: ./dbmgr lookup <dat> in <rep>
(define fn-lookup (lambda (dat rep)
	(if (find-in-file dat (open-input-file rep))
		(display (string-append "The data file '" dat "' is listed in the repository file '" rep "'")) 
		(display (string-append "The data file '" dat "' is NOT listed in the repository file '" rep "'"))
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
		(display (string-append "The data file '" dat "' is NOT listed in the repository file '" rep "'"))
	)
	(newline)
))

; This function lookup for a data filename (dat) in a repository file (rep)
; If the data file doesn't exist in the repository file, the data file will be registred on the repository file
; The params should be the name of the files
; Command-line usage: ./dbmgr register <dat> with <rep>
(define fn-register (lambda (dat rep)
	(if (find-in-file dat (open-input-file rep))
		(display (string-append "The data file '" dat "' is ALREADY listed in the repository file '" rep "'"))
		(begin
			(add-to-file rep dat)
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
			(remove-from-file rep dat)
			(display (string-append "The data file '" dat "' was removed from the repository file '" rep "'"))
		)
		(display (string-append "The data file '" dat "' is NOT listed in the repository file '" rep "'"))
		
	)
	(newline)
))

; This function display a list of data files that are present on the repository file
; The param should be the name of the repository file
; Command-line usage: ./dbmgr list <rep>
(define fn-list (lambda (rep)
	(print-file (open-input-file rep))
	(newline)
))


(define fn-duplicate (lambda (dat1 dat2 rep)
	(cond 
		((not (find-in-file dat1 (open-input-file rep))) 
			(display (string-append "The data file 1 '" dat1 "' is NOT listed in the repository file '" rep "'"))
		)
		((find-in-file dat2 (open-input-file rep)) 
			(display (string-append "The data file 2 '" dat2 "' is ALREADY listed in the repository file '" rep "'"))
		)
		(else 
			(copy-file dat1 dat2)
			(add-to-file rep dat2)
			(display (string-append "The data file 1 '" dat1 "' was duplicated into the data file 2 '" dat2 "'"))
		)
		
	)
	(newline)
))