
public class Main{
	
    public Main() {
    }

    public static void main(String[] args) {	
   	   	Login l = new Login();
   	   	Menu m = new Menu();	
	   	if(l.login()){
	 		Cls.cls();
		   	if(l.getUserType() == 'M')//username = M1001 - password = Manager  		
		   	   	m.managerMenu();		   	   		
		   	else	   	
		   	   	m.staffMenu();//username = T1002 - password = Technician1
	   	}
	}
    
}
