import java.util.*;
import java.io.*;
import java.nio.file.StandardOpenOption;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.format.DateTimeFormatter;
import java.lang.*;
import java.text.SimpleDateFormat;
import java.util.stream.*;
import java.util.regex.Pattern;

public class Timetable extends CurrentWeekDate{
	final static int OPEN_DAY = 6; // 6 operation day from mon to sat
	final static int SEC = 3; // 3 section per day for services
	final static int NUM_TECH = 4;// 4 technician can work concurrently
	
	private String [][][] timetable;
	private String techId;
	private String date;
	private int day;
    private int section;
    private String time;
	public Scanner sc = new Scanner(System.in);
	
	public Timetable(){
	}
	
	public void setTimetable(String[][][]timetable){
		this.timetable = timetable;
	}
	public void setTechId(String t){
    	techId = t;
    }
    public void setDate(String date) {
    	this.date = date;
    }
    public void setDay(int day){
    	this.day = day;
    }
	public void setSection(int section) {
		this.section = section;
    }
    public void setTime(String time){
    	if(getSection() == 1)
    		this.time = "09:00-12:00";
    	else if(getSection() == 2)
    		this.time = "13:00-16:00";
    	else
    		this.time = "16:00-19:00";
    }

    public String[][][] getTimetable(){
    	return timetable;
    }
    public String getTechId(){
    	return techId;
    }
    public String getDate() {
    	return date;
    }
    public int getDay(){
    	return day;
    }
    public int getSection() {
    	return section;
    }
    public String getTime(){
    	return time;
    }

	public void addTimetable(){
		do{
			readTimeTable();
			display();
		
			setDate(dateValidation());
			setDay(checkDayofDate(getDate()));
			setMonDate(getDate());
			setSatDate(getDate());
			
			System.out.println("\n");
			if(!checkBetween(getDateWeek().get(0), getDateWeek().get(5),getDate())){
				readTimeTable();
				reset(getDate());
				display();
			}
			setDay(checkDayofDate(getDate()));
			setSection(Validation.readIntValid(1,3, "Section"));
			setTime("");
				
			if(checkAvaibility()){
				removeTimetable();
				saveTimeTableFile();
			}else
				System.out.println("No technician in this section");
		}while(!checkAvaibility());
	}
	
	public boolean checkAvaibility(){ //check availability of tech in timetable as return time for file storing 
		int techPosition = 0;
		readTimeTable();
		String [][][] time = getTimetable();
			int day2 = getDay();
			int sec2 = getSection();
			
			//check availability of free technireadIntValidcian	
			for(int i= 0; i < NUM_TECH; i++)
				if(!time[day2-1][sec2-1][i].equals("null")){
						techPosition =i; 
						break;
				}
				
			if(!time[day2-1][sec2-1][techPosition].equals("null")){
				setTechId(time[day2-1][sec2-1][techPosition]);
				time[day2-1][sec2-1][techPosition] = null;	//selected techId will be null, indicate not available
				setTimetable(time);
				return true;
			}else{
				return false;
			}
		
	}
	
	public void arrangeTech(){	// arrange available techid in staff.txt into timetable when not timetable in text file
		String [] techId = getTechIds();//get available techId from staff file
		String [][][] time = new String[OPEN_DAY][SEC][NUM_TECH];
		for(int i= 0; i < OPEN_DAY; i++)
			for(int j= 0; j < SEC; j++)
				for(int k= 0; k < techId.length; k++)
					time[i][j][k] = techId[k];
		setTimetable(time);	
	}

	public void display(){//display timetable 
		String[][][]time = getTimetable();
		
		System.out.println("\n\nToday : "+getLocalDate() + "\n-------------------------------");// display date and time	
		System.out.printf("%39s%33s%33s\n", "SEC1 : 09:00-12:00", "SEC2 : 13:00-16:00", "SEC3 : 16:00-19:00");	
		System.out.printf("%39s%33s%33s\n", "------------------", "------------------", "------------------"); 
		for(int i= 0; i < OPEN_DAY; i++){
			System.out.print(new SimpleDateFormat("EEE (dd-MMM)").format(convertStringToDate(getDateWeek().get(i)))+" " + "|" +" ");
			for(int j= 0; j < SEC; j++){
				System.out.print("SEC" + (j+1) + " - ");
				for(int k= 0; k < NUM_TECH; k++)
					if(time[i][j][k] !=null && !time[i][j][k].equals("null") )
						System.out.print(time[i][j][k]+" ");
					else
						System.out.print("----- ");
				System.out.print("| ");  	
			}
		System.out.println();
		}
		System.out.println();
	}
		
	public String[] getTechIds(){  //read staff file and available only return 4 tech id in string array
	    String [] techIds = new String[NUM_TECH]; 
		int count = 0;
		try {
			File file = new File("staff.txt");
			FileReader f = new FileReader(file);
			BufferedReader bufferedReader = new BufferedReader(f);
			StringBuffer stringBuffer = new StringBuffer();
			String line;
			while ((line = bufferedReader.readLine()) != null && count < NUM_TECH) {
				stringBuffer.append(line);
				stringBuffer.append("\n");
				if(line.toUpperCase().contains("technician".toUpperCase())){
				 	techIds[count] = line.substring(0,5);
				 	count++;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return techIds;
	}  
	
	public void saveTimeTableFile(){//save timetable
		setDateRange();
		String time[][][] = getTimetable();
		try(
			FileWriter fw = new FileWriter("timetable.txt", true);
			PrintWriter out = new PrintWriter(fw)){
				out.println(getDateRange());
				for(int i= 0; i < OPEN_DAY; i++){
					String temp ="";//store technician time
					for(int j= 0; j < SEC; j++){
						for(int k= 0; k < NUM_TECH; k++)
							if(time[i][j][k] != null)
								temp += time[i][j][k]+" ";
							else	
								temp += null+ " ";
					}
					temp += "\n";temp = temp.trim();
					out.println(temp);
				}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void removeTimetable(){//remove timetable after 1 appointment is done
		ArrayList<String> list = new ArrayList<String>();
		boolean control = false;
		try{
			Scanner s = new Scanner(new File("timetable.txt"));	//read
			while (s.hasNextLine())
			    list.add(s.nextLine());	
			    	
			Pattern p = Pattern.compile("\\d{2}-\\w{3}-\\d{4}"); //date regex
			int index = 0;
			for (int i = 0; i < list.size(); i++)
				if (p.matcher(list.get(i).substring(0,11)).matches())//check line match regex 
					if(checkBetween(getMonDate(),getSatDate(), list.get(i).substring(0,11))){//check for current week time table
						index = i;
						for(int j= index; j < index + 7; j++)
							list.set(j, list.get(j)+"x");
						control = true;
					}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		if(control){
		
			try (BufferedWriter bw = new BufferedWriter (new FileWriter ("timetable.txt")) ){//rewrite the new list to file			
				for (String line : list)
					bw.write (line + "\n");
			} catch (IOException e) {
				e.printStackTrace ();
			}
			
			removeLine();
		}
	
	}
	
	public void readTimeTable(){//only read for the current week timetable
		String [][][] t = new String[OPEN_DAY][SEC][NUM_TECH];
		int count = 0;
		boolean control = false; 
		String [] str = new String [(OPEN_DAY+1)]; // first line is timetable date
		try{
	   		FileInputStream in = new FileInputStream("timetable.txt");
			BufferedReader br = new BufferedReader(new InputStreamReader(in));    
			String strLine = null, tmp;
			
			while ((tmp = br.readLine()) != null && count < 7){
				str[count] = tmp;
				String temp = str[count].substring(0,11);
				
				if(temp.matches("\\d{2}-\\w{3}-\\d{4}"))
					if(getDate() != null){
					
						if(checkBetween(getMonDate(), getSatDate(),temp))
							control = true;
					}else{
					
						if(checkBetween(getDateWeek().get(0), getDateWeek().get(5),temp)) //check for current week time table
							control = true;
					} 
				
				if(control)
					count++;							
	      	}
        
		}catch(Exception e){
			e.printStackTrace();
		}
		
		if(control){//if timetable is found, arrange into setTimetable		
			for(int i = 0; i < OPEN_DAY; i++){
				String [] details = str[i+1].split(" ");
				int c = 0;
			
				for(int j = 0; j < SEC; j++)
					for(int k = 0; k < NUM_TECH; k++)
						if(details[k] != ""){
							t[i][j][k] = details[c];
							c++;	
						}
			}
			setTimetable(t);
		}else{//timetable not found
			arrangeTech();//new timetable
		}
		
	}
	
	public void removeLine(){
	    try{
		    File file = new File("timetable.txt");
			List<String> out = Files.lines(file.toPath())
					                        .filter(line -> !line.contains("x"))
					                        .collect(Collectors.toList());
			Files.write(file.toPath(), out, StandardOpenOption.WRITE, StandardOpenOption.TRUNCATE_EXISTING);	    
	    }catch(Exception e){
			System.out.print("timetable.txt is not found");
		}
	}
	
	public String dateValidation(){
		System.out.printf("%-25s: ", "Service Date(dd-MMM-yyyy)");
		String date = sc.next();
		String dateRegex = "\\d{1,2}-(?i)(jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)-\\d{4}";
    	while(!date.matches(dateRegex) ||checkSunday(date) ||!smallerDate(date)|| !greaterDate(date)) {
    		if(!date.matches(dateRegex)){   		
    			System.out.print("\n*Invalid Format!*\n");
    		}else if(checkSunday(date))
    			System.out.print("\n*Invalid Date!*\n*Sunday is not operation day.*\n\n");
    		else if(!smallerDate(date))//only allow make appointment within 1 month period
    			System.out.print("\n*Invalid Date!*\n*Appointment date is not started.*\n\n");
    		else if(!greaterDate(date)){
    			System.out.print("\n*Invalid Date!*\n*Appointment date is ended.*\n\n");
    		}
    		System.out.printf("%-25s: ","Service Date (dd-MMM-yyyy)");
    		date = sc.next();
    	}
    	
    	String []details = date.split("-");
    		if(details[0].matches("\\d{1}") ){
    			date = "0" + date;
    		}else if(details[1].matches("\\d{1}")){
    			date = details[0] + ":0" + details[1];
    		}
    	return date.toUpperCase();
 
	}
}
