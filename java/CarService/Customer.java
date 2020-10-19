import java.io.*;
import java.util.*;

public class Customer extends Person{	
	FileHandling f = new FileHandling("customer.txt");
	private int num = f.getLastNum();
	private String id = "C" + ++num;
   	private String carPlate;
   	
	//constructor	
   	public Customer(){
   	}	
	public Customer(String carPlate) {
       	this.carPlate = carPlate;  
    }
    
	//setter
    public void setId(String id) {
        this.id = id;
    }
    public void setCarPlate(String carPlate) {
        this.carPlate = carPlate;
    }
	//getter
	public String getId() {
        return id;
    }
    public String getCarPlate() {
        return carPlate;
    }
    public String toFile(){
    	return String.format("%s\t%s\t%s", id,super.toFile(), carPlate);
    }
	public void savetoFile(){
		try{
			FileHandling.append("customer.txt" , toFile());
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void addCustomer(){
		System.out.println("\nRegistration for New Customer\n=============================");
		System.out.printf("%-25s: %s\n", "Cust id     : ", getId());
		super.addPerson();
		Scanner sc = new Scanner(System.in);
		setCarPlate(Validation.readCarPlate());
		savetoFile();
	}

	public void display(){//display Staff
    	System.out.println("Customer\n========\n");
    	System.out.printf("%-8s%-15s%-15s%-15s%-15s\n", "ID","First_Name", "Last_Name", "Tel_No", "Car Plate No.");
    	System.out.printf("%-8s%-15s%-15s%-15s%-15s\n", "-----","----------", "---------", "-----------", "-------------");
    	try {
            File f = new File("customer.txt");
            Scanner sc = new Scanner(f);//read file	
           
            //separate each element in a line with a variable
            while(sc.hasNextLine()){
                String line = sc.nextLine();
                String[] details = line.split("\t");
                String id = details[0];
                String fName = details[1];
                String lName = details[2];
                String phone =details[3];
                String carPlate =details[4];
                System.out.printf("%-8s%-15s%-15s%-15s%-15s\n",id, fName, lName, phone, carPlate);
            }       
        }catch (FileNotFoundException e){         
            e.printStackTrace();
            System.out.printf("File is not found");      
        }
    }  

}