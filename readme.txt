lab0
Amanda Priscilla Araujo da Silva
Joao Felipe Nicolaci Pimentel

Structure:
-dbmgr.scm is the main file and has functions for parsing the command line, 
verifying the existence or abscence of files and it calls the main functions 
from dbfunc.scm
-dbfunc.scm contains the functions that represents the main features of the 
program. All this features use functions from dbfileutils.scm
-dbfileutils.scm contains the functions that are used to manipulate the 
repoitory and data files


Design decisions:
-Since there is a function "file-exists?" in scheme that checks whether
or not the file exists, we used this function to check the existence or
abscence of files and not the sugestion of identify by trying to open them 
for reading

-For parsing the command line, there is a conditon that checks each valid format 
and calls the desired function in the file dbfunc.scm


Trials:
[jfn1@shell lab0]$ ./dbmgr lookup data.dat in repository.rep
The data file 'data.dat' is listed in the repository file 'repository.rep'

[jfn1@shell lab0]$ ./dbmgr lookup x.dat in repository.rep
The data file 'x.dat' is NOT listed in the repository file 'repository.rep'

[jfn1@shell lab0]$ ./dbmgr lookup data.dat in 'repository_doesnt_exist.rep'
The file repository_doesnt_exist.rep doesn't exist
Error: Bad formed parameters
Usage information:
    ./dbmgr lookup <dat1> in <rep1>
    ./dbmgr print <dat1> of <rep1>
    ./dbmgr register <dat1> with <rep1>
    ./dbmgr remove <dat1> from <rep1>
    ./dbmgr list <rep1>
    ./dbmgr duplicate <dat1> to <dat2> within <rep1>

[jfn1@shell lab0]$ ./dbmgr lookup data.txt in repository.rep
The file 'data.txt' doesn't have the expected extension
Error: Bad formed parameters
Usage information:
    ./dbmgr lookup <dat1> in <rep1>
    ./dbmgr print <dat1> of <rep1>
    ./dbmgr register <dat1> with <rep1>
    ./dbmgr remove <dat1> from <rep1>
    ./dbmgr list <rep1>
	
[jfn1@shell lab0]$ ./dbmgr lookup data.dat of repository.rep
Error: Bad formed parameters
Usage information:
    ./dbmgr lookup <dat1> in <rep1>
    ./dbmgr print <dat1> of <rep1>
    ./dbmgr register <dat1> with <rep1>
    ./dbmgr remove <dat1> from <rep1>
    ./dbmgr list <rep1>
    ./dbmgr duplicate <dat1> to <dat2> within <rep1>
	
[jfn1@shell lab0]$ ./dbmgr print data.dat of repository.rep
Test
New data
Verbatim listing?
2
3
(1 2 3)
       s
\n /n
EOF
The real EOF

[jfn1@shell lab0]$ ./dbmgr print new_data.dat of repository.rep
The data file 'new_data.dat' is NOT listed in the repository file 'repository.re
p'

[jfn1@shell lab0]$ ./dbmgr print datas.dat of repository.rep
The file 'datas.dat' doesn't exist
Error: Bad formed parameters
Usage information:
    ./dbmgr lookup <dat1> in <rep1>
    ./dbmgr print <dat1> of <rep1>
    ./dbmgr register <dat1> with <rep1>
    ./dbmgr remove <dat1> from <rep1>
    ./dbmgr list <rep1>
    ./dbmgr duplicate <dat1> to <dat2> within <rep1>
	


