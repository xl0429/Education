import java.io.*;
import java.util.*;

public class Staff extends Person{
	FileHandling f = new FileHandling("staff.txt");
	private int num = f.getLastNum();
	private String id;
    private char gender;
    private int age;
    private String position;
    private String password;
    Scanner sc = new Scanner(System.in);
    
   	//constructor 
   	public Staff(){
   		
   	}	

	//setter
    public void setId(String id) {
        this.id = id;
    }
    public void setGender(char gender) {
        this.gender = gender;
    }
    public void setAge(int age) {
        this.age = age;
    }
    public void setPosition(String position) {
    	//position only has manager, technician and cashier
    	while(!(position.equals("manager") ||position.equals("technician") ||position.equals("cashier"))){
    		System.out.printf("%s%-25s: ", "*\nInvalid Position! Reenter*\n", "Position");
			position = sc.next().toLowerCase();
    	}
    	this.position = position.toUpperCase();
    	if(position.equalsIgnoreCase("manager"))
    		setId("M" + ++num);
    	else if(position.equalsIgnoreCase("technician"))
    		setId("T" + ++num);
    	else if(position.equalsIgnoreCase("cashier"))
    		setId("S" + ++num);	
       
    }
    public void setPassword(String password) {
        this.password = password;
    }

	//getter
	public String getId() {
        return id;
    }
    public char getGender() {
        return gender;
    }
    public int getAge() {
        return age;
    }
    public String getPosition() {
        return position;
    }
    public String getPassword() {
        return password;
    }   
    public String toFile(){
    	return String.format("%s\t%s\t%c\t%d\t%s\t%s", id,super.toFile(), getGender(), getAge(), getPosition(), getPassword());
    }
	public void savetoFile(){
		try{
			FileHandling.append("staff.txt" , toFile());
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void addStaff(){
		super.addPerson();
		setGender(Validation.readGender());
		setAge(Validation.readIntValid(18,100, "Age"));
		System.out.printf("%-25s: ", "Position");
		setPosition(sc.next().toLowerCase());
		System.out.printf("%-25s: ", "Password");
		setPassword(sc.next());
		
		savetoFile();
		System.out.print("\n\n"+ toFile());
	}
	
	//display ALL Staff
	public void display(){
    	System.out.printf("%-8s%-15s%-15s%-15s%-8s%-5s%-15s%-15s\n", "ID","First_Name", "Last_Name", "Tel_No", "Gender", "Age", "Position", "Password");
    	System.out.printf("%-8s%-15s%-15s%-15s%-8s%-5s%-15s%-15s\n", "-----","----------", "---------", "------", "------", "---", "--------", "--------");
    	try {
            File f = new File("staff.txt");
            Scanner sc = new Scanner(f);//read file	
            //separate each element in a line with a variable
            while(sc.hasNextLine()){
                String line = sc.nextLine();
                String[] details = line.split("\t");
                String staffId = details[0];
                String stafFName = details[1];
                String staffLName = details[2];
                String staffPhone =details[3];
                char staffGender = details[4].charAt(0); 
                int staffAge = Integer.parseInt(details[5]);
                String staffPosition =details[6];
                String staffPassword =details[7];
                System.out.printf("%-8s%-15s%-15s%-15s%-8c%-5d%-15s%-15s\n",staffId, stafFName, staffLName,staffPhone, staffGender, staffAge,staffPosition, staffPassword);
            }       
        }catch (FileNotFoundException e){         
            e.printStackTrace();
            System.out.printf("File is not found");          
        }
    }  

	public void searchStaff(){
		System.out.printf("%-25s: ", "Staff Id");
		String sID = sc.next();
		System.out.println();
		f.displayCertainContent(sID,"staff.txt");
	}
	
	public void deleteStaff(){
		System.out.printf("%-25s: ","Staff Id");
		String sID = sc.next().toUpperCase();
		f.removeLine(sID, "staff.txt");
	}
}
