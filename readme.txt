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
All the trials worked as expected for the following files:
-data.dat:
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

-repository.rep
a.dat
b.dat
d.dat
data.dat
e.dat

-new_data.rep

-e.dat

All explanations for the behavior of the program are in the output

[jfn1@shell lab0]$ ./dbmgr lookup data.dat in repository.rep
The data file 'data.dat' is listed in the repository file 'repository.rep'

[jfn1@shell lab0]$ ./dbmgr lookup new_data.dat in repository.rep
The data file 'new_data.dat' is NOT listed in the repository file 'repository.rep'

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
The data file 'new_data.dat' is NOT listed in the repository file 'repository.rep'

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
	
[jfn1@shell lab0]$ ./dbmgr register new_data.dat with repository.rep
The data file 'new_data.dat' was added to the repository file 'repository.rep'

[jfn1@shell lab0]$ ./dbmgr register data.dat with repository.rep
The data file 'data.dat' is ALREADY listed in the repository file 'repository.rep'

[jfn1@shell lab0]$ ./dbmgr register datas.dat with repository.rep
The file 'datas.dat' doesn't exist
Error: Bad formed parameters
Usage information:
    ./dbmgr lookup <dat1> in <rep1>
    ./dbmgr print <dat1> of <rep1>
    ./dbmgr register <dat1> with <rep1>
    ./dbmgr remove <dat1> from <rep1>
    ./dbmgr list <rep1>
    ./dbmgr duplicate <dat1> to <dat2> within <rep1>
	
[jfn1@shell lab0]$ ./dbmgr remove data.dat from repository.rep
The data file 'data.dat' was removed from the repository file 'repository.rep'

[jfn1@shell lab0]$ ./dbmgr remove new_data.dat from repository.rep
The data file 'new_data.dat' is NOT listed in the repository file 'repository.rep'

[jfn1@shell lab0]$ ./dbmgr list repository.rep
a.dat
b.dat
d.dat
data.dat
e.dat


[jfn1@shell lab0]$ ./dbmgr list repository_doesnt_exist.rep
The file 'repository_doesnt_exist.rep' doesn't exist
Error: Bad formed parameters
Usage information:
    ./dbmgr lookup <dat1> in <rep1>
    ./dbmgr print <dat1> of <rep1>
    ./dbmgr register <dat1> with <rep1>
    ./dbmgr remove <dat1> from <rep1>
    ./dbmgr list <rep1>
    ./dbmgr duplicate <dat1> to <dat2> within <rep1>
	
[jfn1@shell lab0]$ ./dbmgr duplicate data.dat to dat.dat within repository.rep
The data file 1 'data.dat' was duplicated into the data file 2 'dat.dat'

[jfn1@shell lab0]$ ./dbmgr duplicate data.dat to new_data.dat within repository.rep
The file 'new_data.dat' already exists
Error: Bad formed parameters
Usage information:
    ./dbmgr lookup <dat1> in <rep1>
    ./dbmgr print <dat1> of <rep1>
    ./dbmgr register <dat1> with <rep1>
    ./dbmgr remove <dat1> from <rep1>
    ./dbmgr list <rep1>
    ./dbmgr duplicate <dat1> to <dat2> within <rep1>
	
[jfn1@shell lab0]$ ./dbmgr duplicate data.dat to e.dat within repository.rep
The data file 2 'e.dat' is ALREADY listed in the repository file 'repository.rep'

[jfn1@shell lab0]$ ./dbmgr duplicate new_data.dat to new_data2.dat within repository.rep
The data file 1 'new_data.dat' is NOT listed in the repository file 'repository.rep'

[jfn1@shell lab0]$ ./dbmgr duplicate data_doesnt_exist.dat to dat.dat within repository.rep
The file 'data_doesnt_exist.dat' doesn't exist
Error: Bad formed parameters
Usage information:
    ./dbmgr lookup <dat1> in <rep1>
    ./dbmgr print <dat1> of <rep1>
    ./dbmgr register <dat1> with <rep1>
    ./dbmgr remove <dat1> from <rep1>
    ./dbmgr list <rep1>
    ./dbmgr duplicate <dat1> to <dat2> within <rep1>
	
	
	
	
Extra Credit:

Prototyped features: All features:
-lookup
-print
-register
-remove
-list
-duplicate

Language: Java

Overview of design:


How the design and implementation in java was similar and/or different from the approach in Scheme for the assignment: