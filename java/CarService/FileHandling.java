import java.io.*;
import java.lang.*;
import java.nio.file.Files;
import java.nio.file.StandardOpenOption;
import java.util.*;
import java.util.stream.*;


public class FileHandling{
	
	private int lastNum; // for all to add record(the auto generating number)except transaction file;
	private int transLNum;// for add transaction 
	private String custId;// for check customer in add transaction
	private String transaction;// be shown in payment
	private double tPayment;//total payment
	  
	public FileHandling(){	
	}
	public FileHandling(String fileName){
		try{
			readLastNum(fileName);
		}
		catch(Exception e){
			//if not file in directory
			try{
				FileOutputStream out = new FileOutputStream(fileName);
				System.out.println("New " + fileName + " created.");
			}catch(Exception ex){
				System.out.println("Cannot create new " + fileName);
			}
			setLastNum(1000);// reset the numbering for the id for new file staffing from 1001
			setTransLNum(1000);
		}
	}
	
	//setter
	public void setLastNum(int n){
		lastNum = n;
	}
	public void setTransLNum(int tn){
		transLNum = tn;
	}
	public void setCustId(String id){
		custId = id;
	}
	public void setTransaction(String t){
		transaction = t;
	}
	public void settPayment(double tP){
		tPayment = tP;
	}
	
	//getter
	public int getLastNum(){
		return lastNum;	
	}
	public String getCustId(){
		return custId;
	}
	public int getTransLNum(){
		return transLNum;
	}
	public String getTransaction(){
		return transaction;
	}
	public double gettPayment(){
		return tPayment;
	}
	
	public static void append(String fName, String toFile) throws IOException {	//append string in to file
			File dir = new File(".");
			String loc = dir.getCanonicalPath() + File.separator + fName;	 
			FileWriter fstream = new FileWriter(loc, true);
			BufferedWriter out = new BufferedWriter(fstream);	 
			out.write(toFile);
			out.newLine();
			out.close();	//close buffer writer
		
	}
	
	public void readDisplay(String fileName){// display all from file
		try{		
			FileInputStream in = new FileInputStream(fileName);
			BufferedReader br = new BufferedReader(new InputStreamReader(in)); 
			String strLine = null, tmp;
			while ((tmp = br.readLine()) != null)
			   System.out.println(tmp);	
		}catch(Exception e){
			System.out.print(fileName + " is not found");
		}
	}
	
	public void displayCertainContent(String content, String fileName){//only display line(s) has content
		double total = 0;
		if(!readContentInFile(content, fileName))
			System.out.println(content + " is not found in " + fileName + ".");
		else{	
			try{		
				FileInputStream in = new FileInputStream(fileName);
				BufferedReader br = new BufferedReader(new InputStreamReader(in)); 
				String strLine = null, tmp;
				if(fileName == "transaction.txt"){
					System.out.println("tranID	custId  CarNo.  date        time	    techId");
					System.out.println("------	------  ------  ----------- ----	    ------");
				}
				while ((tmp = br.readLine()) != null){
				
					if(tmp.toUpperCase().contains(content.toUpperCase())){
					
						System.out.println(tmp);
						if(fileName =="payment.txt"){
							String[] details = tmp.split("\t");
							String value =  details[details.length-1];
							total += Double.parseDouble(value);
						}
					}
				}
			}catch(Exception e){
				System.out.print(fileName + " is not found");
			}
		}
		settPayment(total);
	}
	
	public void readLastNum(String fileName) throws Exception {	//read the last line file, set the id number
		FileInputStream in = new FileInputStream(fileName);
		BufferedReader br = new BufferedReader(new InputStreamReader(in)); 
		String strLine = null, tmp;
		while ((tmp = br.readLine()) != null)
		   strLine = tmp;	
		String lastLine = strLine;
		if(fileName != "transaction.txt")
			setLastNum(Integer.parseInt(lastLine.substring(1,5)));//C1001, S1001
		else
			setTransLNum(Integer.parseInt(lastLine.substring(2,6)));//TR1001
	}
	
	public void removeLine(String lineContent, String fileName){//remove line contain certain content(eg. id)
	    try{
		    File file = new File(fileName);
		    if(!readContentInFile(lineContent, fileName))
		    	System.out.println("No " + lineContent + " in file");
		    else{
		    	System.out.println("\n\nAre yous sure want to delete ?\n1. Yes\n2. No\n");
				int selection = Validation.readIntValid(1,2, "Selection");
				if(selection == 1){
				    List<String> out = Files.lines(file.toPath())
				                        .filter(line -> !line.contains(lineContent))
				                        .collect(Collectors.toList());
				    Files.write(file.toPath(), out, StandardOpenOption.WRITE, StandardOpenOption.TRUNCATE_EXISTING);	    
				    System.out.println("\n\n*"+lineContent+" is deleted Successfully.*");
				}
				else
					System.out.print("\n\n*You delete nothing*");
		    }
	    }catch(Exception e){
			System.out.print(fileName +  "is not found");
		}
	}

	public Boolean readContentInFile(String lineContent, String fileName){//to find a certain content in file
		int control = 0; //using int to perform control as return statement cannot be use in try statement
		try{
			File file = new File(fileName);
			FileReader f = new FileReader(file);
			BufferedReader bufferedReader = new BufferedReader(f);
			StringBuffer stringBuffer = new StringBuffer();
			String line;
			while ((line = bufferedReader.readLine()) != null) {
				stringBuffer.append(line);
				stringBuffer.append("\n");
				
				if(line.toUpperCase().contains(lineContent.toUpperCase())){
					if(fileName == "transaction.txt"){
						String tmp = line;
						setTransaction(tmp);//get transaction details to show in payment
					}
					setCustId(line.substring(0,5));//to find customer id from car plate
				 	control =1;
				 	break;
				}
			}
			
		}catch (IOException e) {
			e.printStackTrace();
		
		}
		if(control == 1)
			return true;
		else
			return false;
			
	}  
	
	public String readLastValue(String lineContent, String fname){//return last element in string as line content compatible
		String value=null;
		try{
			File file = new File(fname);
			FileReader f = new FileReader(fname);
			BufferedReader bufferedReader = new BufferedReader(f);
			StringBuffer stringBuffer = new StringBuffer();
			String line;
			while ((line = bufferedReader.readLine()) != null) {
				stringBuffer.append(line);
				stringBuffer.append("\n");
				if(line.toUpperCase().substring(0,5).equals(lineContent)){
					String[] details = line.split("\t");
					value =  details[details.length-1];
					break;	
				}	
			}
		}catch (IOException e) {
			e.printStackTrace();
		}
		return value;		
	}
		
	public int countWax(String id){//check the count of times of wax for a cust_id
		int count = 0;
		try{		
			FileInputStream in = new FileInputStream("transaction.txt");
			BufferedReader br = new BufferedReader(new InputStreamReader(in)); 
			String strLine = null, tmp;
			while ((tmp = br.readLine()) != null)
				if(tmp.contains(id) && tmp.contains("TW") )
					count++;
		}catch(Exception e){
			System.out.print("transaction.txt" + " is not found");
		}
		return count;
		
	}


}