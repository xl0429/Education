import java.util.Scanner;
public class Validation{//method abstraction
	public static Scanner sc = new Scanner(System.in);
	
    //read only valid integer input in a certain range
    public static int readIntValid(int min, int max, String s){//min = first selection, last selection
    	System.out.printf("%-25s: ", String.format(s + "[ " +min + "-" + max + " ]"));
    	int selection = 0;
		 do{
		 	try {
		 		String input = sc.next();//capture input in String, prevent error for different data type input
		 		selection = Integer.parseInt(input); 
		 		if(selection < min || selection > max)
		 			System.out.printf("%s%-25s: ", "*\nInvalid input!*\n", String.format(s + "[ " +min + "-" + max + " ]"));
		 	}catch(NumberFormatException  e) {//check for integer value
		 		System.out.printf("%s%-25s: ", "\n*Invalid input!*\n", String.format("Reenter a number" + "[ " +min + "-" + max + " ]"));
			}
		 }while(selection < min || selection > max);
    	return selection;
    }
	
	//read and validate a Gender
	public static char readGender(){
		Scanner sc = new Scanner(System.in);
		char input=' ';
		System.out.printf("%-25s: ", "Gender [ M / F ]");
		do{
			input = sc.next().charAt(0);
			input = Character.toUpperCase(input);
			if(!Character.isLetter(input))
				System.out.printf("%s\n%-25s: ", "\n*Invalid Input!*","Reenter a char [M/F]" );
			else if(input != 'M' && input != 'F')
				System.out.printf("%s\n%-25s: ", "\n*Invalid Input!*","Gender [ M / F ]" );
		}while(input != 'M' &&input != 'F');
		
		return input;
		
	}
	
	public static double readDoubleValid(String name){//read valid double value
		double value = 0;
		while(true){
			try{
				System.out.printf("%-25s: ", name);
				value = Double.parseDouble(sc.next());
				break;
			}catch(Exception e){
				System.out.printf("\n%-25s", String.format("\n*Invalid "+name+" Reenter!*\n"));
			}
		}
		return value;		
	}
	
	public static double readDoubleValid(String stm, String name){
		double value = 0;
		while(true){
			try{
				System.out.print(stm);
				value = Double.parseDouble(sc.next());
				break;
			}catch(Exception e){
				System.out.println("\n*Invalid "+ name + " ! Reenter.*");
			}
		}
		return value;		
	}
	
	
	public static String readCarPlate(){
		Scanner sc = new Scanner(System.in);
		String input="";
		System.out.printf("%-25s: ", "Car Plate (WMS1234)");
		while(input.length()< 4){
	        input = sc.next();
	        input.replaceAll("\\s+","");
			input=input.toUpperCase();
			if(input.length()< 4)
				System.out.printf("%s%-25s: ","\n*Invalid Input!*\n", "Car Plate (WMS1234)");
		}
		return input;
	}
        

    public static String readDate(String d){
    	d = d.toUpperCase();
    	while(!d.matches("[0-9]{1,2}-[a-zA-Z]{3}-[0-9]{4}")){
    		System.out.printf("%s%-25s: ", "\n*Invalid Date!.*\n", "Date");
    		d = sc.next();
    	}
        return d.toUpperCase();
    }
	
    public static char readSelection(){//avoid user enter wrong number and alphabet
    	Scanner scanner = new Scanner(System.in);
        char select;
        do{System.out.println("Choose [1-5] :");
            select = scanner.next().charAt(0);
            if(!Character.isDigit(select)){
           	 System.out.println("Invalid input! Not allow letter!");
        }
      }while(select<'1'||select>'5');
        return select; 
    }
}