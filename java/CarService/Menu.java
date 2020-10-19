import java.util.Scanner;
import java.io.*;
public class Menu{
	private String tType;// transaction type will change follow different service
	Scanner sc = new Scanner(System.in);
	
	public Menu(){
				
	}
	public void setTType(String t){
		tType =t;
	}
	public String getTType(){
		return tType;
	}
	
	public void staffMenu(){// staff login will get this menu
		int selection = 0;
		do{
			Cls.cls();
			System.out.println("Staff Menu\n==========");
			System.out.println("1. Appointment\n2. Payment\n3. Check Trans. - Car Plate \n4. Check Task   - Tech. Id\n5. EXIT\n");
			selection = Validation.readIntValid(1,5, "Selection");
			Transaction t =new Transaction();
			Cls.cls();
			System.out.println();
			switch(selection){
	  			case 1:
	  				addTransMenu();	
	  				break;
	  			case 2:
	  				Payment p = new Payment();
	  				p.addPayment();
	  				break;
	  			case 3:
	  				System.out.println("Check Transaction by Car Plate\n------------------------------");
	   				t.checkCarPlate();
	  				break;
				case 4:
					System.out.println("Check Task by Technician Id\n---------------------------");
	  				t.checkTechnician();
	  				break;
	  			case 5:
	  				System.exit(0);
	  		}
	  		Cls.promptEnterKey();
	  		Cls.cls();
  		}while(selection != 5);
	}
	
	public void serviceMenu(){//service menu
		Cls.cls();
		System.out.println("Service\n-------");
   		System.out.println("1. Repair\n2. Repaint\n3. Wax & Polish\n4. Maintenance\n5. Inspection\n6. STAFF MENU\n7. EXIT\n");
  		int selection = Validation.readIntValid(1,7, "Selection");
  		System.out.println();
  		Transaction t =new Transaction();
  		Cls.cls();
  		switch(selection){
  			case 1:
  				System.out.println("Repair");// tCode = TR
  				t.setTransCode("TR");
  				break;
  			case 2:
  				System.out.println("Repaint");// tCode = TP
  				t.setTransCode("TP");
  				break;
  			case 3:
  				System.out.println("Wax & Polish");// tCode = TW
  				t.setTransCode("TW");
  				break;
			case 4:
  				System.out.println("Maintenance");// tCode = TM
  				t.setTransCode("TM");
  				break;
  			case 5:
  				System.out.println("Inspection");// tCode = TI
  				t.setTransCode("TI");
  				break;
  			case 6:
  				staffMenu();
  				break;
  			case 7:
  				System.exit(0);
  		}
  		System.out.println("============");
  		//System.out.println("\n\nasd" + getTType());
		t.addTransaction();
		
	}
	
	public void managerMenu(){// manager login will get this menu
		int selection = 0;
		do{
			Cls.cls();
			System.out.println("Manager Menu\n============");	
	    	System.out.println("1. View Report(Daily / Monthly)\n2. Staff Handling\n3. Exit\n");
	  		selection = Validation.readIntValid(1, 3, "Selection");	
	  		switch(selection){
	  			case 1:
	  				reportMenu();
	  				break;
	  			case 2:
	  				addStaffMenu();
	  				break;
	  			case 3:
	  				System.exit(0);
	  		}
	  		Cls.promptEnterKey();
  		}while(selection != 3);
	}
	
	public void addStaffMenu(){//adding new staff only use by manager
		Cls.cls();
		System.out.println("\nStaff Handling Menu");
		System.out.println("---------------");
		System.out.println("1. Add staff\n2. Display All Staff\n3. Search Staff\n4. Delete Staff\n5. BACK\n6. EXIT");
		int selection = Validation.readIntValid(1, 6, "Selection");
		Staff s = new Staff();
		Cls.cls();
		switch(selection){
			case 1:
				System.out.println("REGISTER STAFF\n--------------");	
				s.addStaff();
				break;
			case 2: 
				System.out.println("DISPLAY STAFF\n-------------");	
				s.display();
				break;
			case 3:
				System.out.println("SEARCH STAFF\n------------");	
				s.searchStaff();
				break;
			case 4:
				System.out.println("DELETE STAFF\n------------");	
				s.deleteStaff();
				break;
			case 5:
				managerMenu();
				break;
			case 6:
				System.exit(0);		
		}
	}

	public void addTransMenu(){
		Cls.cls();
		System.out.println("\nAppointment Menu\n===============");
   	    System.out.println("1. Add\n2. Search\n3. Delete\n4. BACK\n5. EXIT");
        int selection = Validation.readIntValid(1,5,"Choose");
        Transaction t = new Transaction();
        Cls.cls();
        System.out.println();
        switch(selection){
			case 1:
			  	System.out.println("Add Appointment");
			  	System.out.println("===============");
			    serviceMenu();
			    break;
			case 2:
			  	System.out.println("Search Appointment");
			  	System.out.println("=================== ");
			  	t.searchTransaction();
			    break;
			case 3:
			  	System.out.println("Delete Appointmentt");
			  	System.out.println("=================== ");
			  	t.deleteTransaction();
			    break;
			case 4:
			  	staffMenu();
			    break;
			case 5:
			  	System.out.println("Exit");
  			}
  	
	}
	
	public void reportMenu(){
		Cls.cls();
		System.out.println("\nReport Menu\n===============");
   	    System.out.println("1. Daily\n2. Monthly\n3. BACK\n4. EXIT");
        int selection = Validation.readIntValid(1,5,"Choose");
        Payment p = new Payment();
        Cls.cls();
        System.out.println();
        switch(selection){
			case 1:
			  	System.out.println("Daily Transaction");
			  	System.out.println("=================== ");
			    p.checkDailyPayment();
			    break;
			case 2:
			  	System.out.println("Monthly transaction");
			  	System.out.println("=================== ");
			  	p.checkDailyPayment();
			    break;
			case 3:
			  	managerMenu();
			    break;
			case 4:
			  	System.out.println("Exit");
  			}

	}

}