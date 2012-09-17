import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Collections;


public class Dbmgr {

  /**
	 *
	 * @author Amanda Priscilla Araujo da Silva
	 * @author Joao Felipe Nicolaci Pimentel
	 * 
	 * @param args
	 */

	/* Filename: Dbmgr
	   Description: Program with commands to manipulate repository file and data files*/ 
	
	/** Variable to store class name*/
	private String appName = this.getClass().getCanonicalName();
	
	/** Variable to store the list of names from a repository when reading it*/
	private ArrayList<String> list = new ArrayList<String>();	
	
	/** Method with usage information in case user types wrong parameters*/
	public void helpfulMessage(){
		System.out.println("Usage Information:");
		System.out.println("     "+appName+" lookup <dat1> in <rep1>");
		System.out.println("     "+appName+" print <dat1> of <rep1>");
		System.out.println("     "+appName+" register <dat1> with <rep1>");
		System.out.println("     "+appName+" remove <dat1> from <rep1>");
		System.out.println("     "+appName+" list <rep1>");
		System.out.println("     "+appName+" duplicate <dat1> to <dat2> within <rep1>");
	}
	
	
	
	public static void main(String[] args) {
		Dbmgr program = new Dbmgr();
			
		// If there are arguments and files exist -> continue	
		  if(args.length > 1) {
			
			if(args[0].equals("lookup")){
				if(program.checkFiles(args[3], ".rep") && program.checkParams(args, 4, "in")) program.lookup(args[1], args[3]);
			} else	
			if(args[0].equals("print")){	
				if(program.checkFiles(args[1], ".dat") && program.checkFiles(args[3], ".rep") && program.checkParams(args, 4, "of")) program.print(args[1], args[3]);
			} else
			if(args[0].equals("register")){
				if(program.checkFiles(args[1], ".dat") && program.checkFiles(args[3], ".rep") && program.checkParams(args, 4, "with")) program.register(args[1], args[3]);
			} else
			if(args[0].equals("remove")){
				if(program.checkFiles(args[3], ".rep") && program.checkParams(args, 4, "from")) program.remove(args[1], args[3]);
			} else
			if(args[0].equals("list")){
				if(program.checkFiles(args[1], ".rep")) program.list(args[1]);
			} else
			if(args[0].equals("duplicate")){
				if(program.checkFiles(args[1], ".dat") && program.checkFiles(args[5], ".rep") && program.checkParams(args, 6, "to within")) program.duplicate(args[1], args[3], args[5]);
			} else {
				/*If the argument doesn't match any option*/
				System.err.println("Error: bad formed parameters");
				System.err.flush();
				program.helpfulMessage();
			}
		} else program.helpfulMessage();
	}


	/** Method to lookup if the filename can be found in the repository */
	private void lookup(String dat, String rep) {
		int line = this.read(dat, rep, "lookup");
		if(line > 0) 
			System.out.println("The data file '"+dat+ "' is listed in the repository file '" + rep +"'");
		else 
			System.out.println("The data file  '"+dat+ "' is NOT listed in '" + rep+"'");		
	}

	/** Method to print a file only if its filename can be found in the repository */
	private void print(String dat, String rep) {
		if(this.read(dat, rep, "lookup") > 0) 
			//Using same method with different parameters to print
			read(" ", dat, "print");
		else 
			System.out.println("The data file  '"+dat+ "' is NOT listed in '" + rep+"'");		
	
	}

	/** Method to register a filename in the repository file*/
	private void register(String dat, String rep) {
		// Reset the global list of lines
		list = new ArrayList<String>();
		int line = this.read(dat, rep, "lookup");
		if(line > 0) 
			System.out.println("The data file '"+dat+ "' is ALREADY listed on the repository file  '" + rep +"'");
		else{
			list.add(dat);
			Collections.sort(list);
			if(write(list, rep))
				System.out.println("The data file '"+dat+ "' was added to the repository file '"+rep+"'");
		}
			
	}
	
	/** Method to remove a registered filename from the repository file*/
	private void remove(String dat, String rep) {
		int line = this.read(dat, rep, "lookup");
		if(line > 0){
			// Reset the global list of lines
			list = new ArrayList<String>();
			this.read("", rep, "");
			
			if(list.remove(dat)){
				if(write(list, rep))
					System.out.println("The data file '"+dat+ "' was removed from the repository file '"+rep+"'");
			} 
		}else System.out.println("The data file '"+dat+ "' is NOT listed in the repository file '"+rep+"'");
		 	
		
	}


	private void list(String rep) {
		this.read(" ", rep, "list");
	}

	private void duplicate(String dat1, String dat2, String rep) {
		if(!dat2.endsWith(".dat")) 
			System.out.println("The file '"+dat2+"' doesn't have the expected extension.");
		else
		if((new File(dat2)).exists()) 
			System.out.println("The file '"+dat2+ "' ALREADY exists!");
		else{
			int line = this.read(dat1, rep, "lookup");
			/* Check if the dat1 is listed in the repository, if not listed, show error and terminate */
			if(line > 0) {
				line = this.read(dat2, rep, "lookup");
				
				/* Check if dat2 is listed in the repository, if listed show error and terminate */
				if(line > 0) System.out.println("The file '"+dat1 +"' is ALREADY listed in the repository.");
				else{
					/* Register the new filename*/
					list.add(dat2);
					Collections.sort(list);
					if(write(list, rep)){
						/* Reset the list to receive the lines from dat1*/
						list = new ArrayList<String>();
						this.read("", dat1, "");
						/* Saves dat2 file */
						if(write(list, dat2)){
							System.out.println("The data file '"+dat1 +"' was duplicated into the data file '"+dat2+"'");
						}
					}
				}
			} else System.out.println("The file '"+dat1 +"' is NOT listed in the repository."); 
		 
		
		}
	}
	
	/** Method to write a name in a file repository keeping the sorting order*/
	private boolean write (ArrayList<String> lines, String filename) {
		 
		try{
			File file = new File(filename);
			Writer output = new BufferedWriter(new FileWriter(file));

			for(int i = 0; i < lines.size(); i++){
				if (lines.get(i).trim().length() > 0)
				{
					output.write(lines.get(i));
					output.write("\n");	
				}
			}
			output.flush();
			output.close();
		} catch (Exception e) {//Catch exception if any 
			System.out.println("Error to write the file. Details: " + e);
			return false;
		} 

		return true;
	}
	
	/** Method to read file repository and find a name inside it*/
	private int read (String keyword, String file, String command) {
			int line = 0, fline = 0;
			try{								
				// Open the file
				FileInputStream fstream = new FileInputStream(file);
				// Get the object of DataInputStream
				DataInputStream in = new DataInputStream(fstream);
				BufferedReader br = new BufferedReader(new InputStreamReader(in));
				String strLine;
				
				// Announce of Print Command! 
				if(command.equals("print")) System.out.println("Printing file "+file+":");

				
				//Read File Line By Line
				while ((strLine = br.readLine()) != null)   {
					// Count file lines
					line++;	
					
					if(command.equals("print") || command.equals("list")) System.out.println(strLine);
										
					// If the filename is found, take the line and break!
					if(command.equals("lookup") && strLine.equals(keyword)){
						fline = line;
						break;
					}
					// Refresh global collection with current file lines 
					list.add(strLine);				
				}
				//Close the input stream
				in.close();
			}catch (Exception e){//Catch and show exception if any
				System.err.println("Error to open the file! Details: " + e.getMessage());
			}
			return fline;
			
			
	}
	

	/** Method checks if all required files exist
	 * @return boolean
	 * */ 
	public boolean checkFiles(String file, String extension) {
		if(!(new File(file)).exists()) {
			System.err.println("The File '"+file +"' doesn't exist!");
			System.err.flush();
			helpfulMessage();

			return false;
		} else
			if(!file.endsWith(extension)){
				System.err.println("The file '"+file+"' doesn't have the expected extension.");
				System.err.flush();
				helpfulMessage();

				return false;
		}
		return true;	
	}

	/** Method checks if all parameters are appropriate
	 * @return boolean
	 * */ 
	public boolean checkParams(String[] args, int len, String separator){
		// Verify if the number of parameters and separator match with the expected
	  if(len == 4)
		if(args.length < len || !args[2].equals(separator)){ 
			System.err.println("Error: bad formed parameters");
			System.err.flush();
			helpfulMessage();
			return false;
		}
	  if(len == 6)
		  if(args.length < len || !(args[2].equals(separator.split(" ")[0]) && args[4].equals(separator.split(" ")[1]))){
			  System.err.println("Error: bad formed parameters");
				System.err.flush();
				helpfulMessage();
				return false;		  
		  }	  
		return true;
	}	
}