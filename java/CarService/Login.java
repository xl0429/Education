import java.util.Scanner;
public class Login{
	private String username; // must be Staff id in text file
	private String password;
	private char userType;
	Scanner sc = new Scanner(System.in);
	FileHandling f= new FileHandling();
	//getter
	public String getUsername(){
		return username;
	}
	public String getPassword(){
		return password;
	}	
	public char getUserType(){
		return userType;
	}	
		
	//setter
	public void setUsername(String u){
		username = u.toUpperCase();
	}
	public void setPassword(String p){
		password = p;
	}
	public void setUserType(char t){
		userType = t;
	}
	
	
	public boolean login(){
    	System.out.println("\nFIRST CHOICE CAR SERVICES CENTRE");
    	System.out.println("================================\n");
    	System.out.println("Log In");
    	System.out.println("------");
    	
    	if(!checkUserName()||!checkPassword()){
    		System.out.println("\n***Fail to login***");
    		return false;
    	}else
    		return true;
	}
	
	public boolean checkUserName(){
		System.out.printf("%-25s: ", "Staff ID");
		setUsername(sc.next());
		int count = 1;//user are only given 3 times to enter username
		while((f.readLastValue(getUsername(), "staff.txt")== null) && count < 3){
			System.out.printf("%s%-25s: ", "\n*Invalid username!*\n", "Staff ID");
			setUsername(sc.next());
			count++;
			
		}
		if(f.readLastValue(getUsername(), "staff.txt")!= null){
			setUserType(getUsername().toUpperCase().charAt(0));
			return true;
		}else{
		
 			return false;
 		}
	}
	
 	public boolean checkPassword(){
 		System.out.printf("%-25s: ", "Password");
 		setPassword(sc.next());
 		int count =1;//user are only given 3 times to enter password
 		while(!getPassword().equals(f.readLastValue(getUsername(), "staff.txt")) && count < 3){
 			System.out.printf("%s%-25s: ", "\n*Invalid Password!*\n", "Password");
 			setPassword(sc.next());
 			count++;
 		
 		}
 		if(getPassword().equals(f.readLastValue(getUsername(),"staff.txt"))){
			return true;
		}else{
 			return false;
 		}
 
 	}
 	
 	
}