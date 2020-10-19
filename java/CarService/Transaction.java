import java.io.*;
import java.util.*;

public class Transaction extends Timetable{
	FileHandling f = new FileHandling("transaction.txt");//read from transaction file
    private int num = f.getTransLNum();
	private String transCode;
	private String custId;
	private String carPlate;
   
    
    Scanner scanner = new Scanner(System.in);
    
   	//constructor
   	public Transaction(){	
   	}	 
	
	//setter
	public void setTransCode(String c){
		transCode = c;
	}
	public void setCustId(String id){
    	custId = id;
    }
    public void setCarPlate(String carPlate){
    	this.carPlate = carPlate;
    }
    
	//getter
	public String getTransCode(){
		return transCode;
	}
	public String getCustId(){
    	return custId;
    }
    public String getCarPlate(){
    	return carPlate;
    }
   
   
	public String toFile(){//return String save to file
  		return String.format("%s\t%s\t%s\t%s\t%s\t%s",transCode, custId,carPlate, getDate(),getTime(),getTechId());
	}
	public String toString(){//return String print on screen
            return String.format("%-15s%-15s%-15s%-15s%-15s%-8s", transCode, custId, carPlate, getDate(),getTime(),getTechId());
	}

	public void savetoFile(String fName, String str){
		try{
			FileHandling.append(fName , str);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void addTransaction(){
		char ans1;
		setTransCode(getTransCode() + ++num);
		System.out.printf("%-25s: %s","Transaction Code", getTransCode());
	
       	System.out.print("\n\nPrevious Customer?\n1. Yes\n2. No\n");
		int ans = Validation.readIntValid(1, 2, "Choose");
		System.out.println();
		if (ans == 1){
           	setCarPlate(Validation.readCarPlate());
           	FileHandling f = new FileHandling();//read customer file to find the similar car plate
           	if(!f.readContentInFile(carPlate,"customer.txt")){ //if car plate is not found
           		System.out.println("\nYou are not previous customer. Please Register: ");
           		registerNewCustomer();
           		
           	}else{        	
           		setCustId(f.getCustId());//get the cust_id for that car plate
           		System.out.printf("\n%-25s: %s\n\n", "Cust ID", getCustId());
           	}
		}else{
			registerNewCustomer();
		}
		
		addTimetable();
		displayTransaction();
		savetoFile("transaction.txt", toFile());
		
	}
	
	public void displayTransaction(){
		System.out.printf("\n\n%-15s%-15s%-15s%-15s%-15s%-8s\n","Trans. Id", "Cust. Id", "Car Plate", "Date", "Time", "Tech. Id");
	   	System.out.printf("%-15s%-15s%-15s%-15s%-15s%-8s\n","---------", "--------", "---------", "-----------", "-----------", "--------");
	    System.out.println(toString());
	}
	
	public void checkCarPlate(){
		String cPlate = Validation.readCarPlate();
		System.out.println();
		f.displayCertainContent(cPlate, "transaction.txt");
	}
	
	public void checkTechnician(){
		System.out.printf("%-25s: ", "Technician id");
		String technicianId = scanner.next();
		System.out.println();
		f.displayCertainContent(technicianId, "transaction.txt");
		
	}
	
	public void deleteTransaction(){
		System.out.printf("%-25s: ","Transaction Code : ");
		String tCode = scanner.next();
		f.removeLine(tCode.toUpperCase(), "transaction.txt");
	}
	
	public void searchTransaction(){
		System.out.printf("%-25s: ", "Transaction Code : ");
		String tCode = scanner.next();
		System.out.println();
		f.displayCertainContent(tCode, "transaction.txt");
		
	}
	
	public void registerNewCustomer(){//read customer details and store into customer file 
		Customer c = new Customer();
	    c.addCustomer();
	    setCustId(c.getId());
	    setCarPlate(c.getCarPlate());
	}
	

}