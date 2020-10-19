import java.util.Scanner;
public class Person {
    private String fName;
    private String lName;
    private String phone;
    Scanner sc1 = new Scanner(System.in);
    Scanner sc2 = new Scanner(System.in);
    public Person(){
    }
    
	//setter
    public void setfName(String fName) {
        this.fName = fName;
    }
    public void setlName(String lName) {
        this.lName = lName;
    }
    public void setPhone(String phone) {
		while(!phone.matches("[0][1]\\d{1}-\\d{7,8}")){
			System.out.printf("%s%-25s: ", "\n*Invalid Input! Reenter.*\n", "Tel. No (012-3456789)");
			phone = sc2.next();				
		}
        this.phone = phone;
    }

   //getter        
    public String getfName() {
        return fName;
    }
    public String getlName() {
        return lName;
    }
    public String getPhone() {
    	
        return phone;
    }
    
    
    public String toFile(){
    	return fName +'\t' + lName + '\t' + phone;
    }
    public String toString(){
    	return String.format("%-15s%-15s%-15s",fName, lName, phone);
    }
    
    public void addPerson(){
    	System.out.printf("%-25s: ","First Name");
		setfName(sc1.nextLine());
		System.out.printf("%-25s: ", "Last Name");
		setlName(sc2.nextLine());
		System.out.printf("%-25s: ", "Tel. No (012-3456789) : ");
		setPhone(sc1.next());
    }


}