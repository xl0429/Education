import java.text.SimpleDateFormat;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.text.ParseException;
import java.text.DateFormat;
import java.time.format.DateTimeFormatterBuilder;
import java.util.Date;
import java.util.Calendar;


public class CurrentWeekDate {
	Calendar c = new GregorianCalendar(TimeZone.getTimeZone("KL/Asia"));
	DateTimeFormatter dtf = new DateTimeFormatterBuilder()
                .parseCaseInsensitive()
                .parseLenient()
                .appendPattern("dd-MMM-yyyy")
                .toFormatter();
	LocalDateTime now = LocalDateTime.now();  
		
    private List<String> dateWeek = new ArrayList<>();
    private String dateRange;//operating date range for a particular date
    private String monDate;
    private String satDate;
     
    //constructor
    public CurrentWeekDate() {
    	//setDateWeek();
    	if(monDate == null){//no date being assign, use current date
	    	dateWeek.add(dtf.format(now.with(DayOfWeek.MONDAY)).toUpperCase());
			dateWeek.add(dtf.format(now.with(DayOfWeek.TUESDAY)).toUpperCase());
			dateWeek.add(dtf.format(now.with(DayOfWeek.WEDNESDAY)).toUpperCase());
			dateWeek.add(dtf.format(now.with(DayOfWeek.THURSDAY)).toUpperCase());
			dateWeek.add(dtf.format(now.with(DayOfWeek.FRIDAY)).toUpperCase());
			dateWeek.add(dtf.format(now.with(DayOfWeek.SATURDAY)).toUpperCase());
    	}
    }
      	
	//getter
    public List<String> getDateWeek() {
  		return dateWeek;
	}
	public String getDateRange(){
		return dateRange;
	}
	public String getMonDate(){
		return monDate;
	}
	public String getSatDate(){
		return satDate;
	}
	public String getLocalDate() {	//get local date    
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("EEE dd-MMM-yyyy HH:mm");  
		return dtf.format(now);  
	} 

	//setter
    public void setDateWeek(List<String> d){//current week operating  date
    	this.dateWeek = d;
    }
    public void setDateRange(){//given date and set the monday and saturday date of that date
        this.dateRange = getMonDate() + "->" + getSatDate();
    }
    public void setMonDate(String s){
    	LocalDate localDate = LocalDate.parse(s, dtf);
    	monDate = dtf.format(localDate.with(DayOfWeek.MONDAY));
    }
   	public void setSatDate(String s){
   		LocalDate localDate = LocalDate.parse(s, dtf);
   		satDate = dtf.format(localDate.with(DayOfWeek.SATURDAY));
   	
   	}
   	
	public boolean checkBetween(String startDate,String endDate,String dateToCheck) { //date range check
		Date d = convertStringToDate(dateToCheck);
		Date s = convertStringToDate(startDate);
		Date e = convertStringToDate(endDate);
	    return d.compareTo(s) >= 0 && d.compareTo(e) <=0;
	}	    
		
	public boolean greaterDate(String s){//check the date is greater or equal to current date
		return  convertStringToDate(s).compareTo(convertStringToDate(dtf.format(now))) >= 0  ;
	}
	
	public boolean smallerDate(String s){//check the date must less than the current date plus one month
    	return convertStringToDate(s).compareTo(convertStringToDate(dtf.format(now.plusMonths(1)))) <= 0 ;
	}
	
	public boolean checkSunday(String s){
		if(checkDayofDate(s) == 7)
			return true;
		else
			return false;
	}
	
	public Date convertStringToDate(String strDate){
		Date date = new Date();
		DateFormat format = new SimpleDateFormat("dd-MMM-yyyy");
		try{
			date = format.parse(strDate);
		}
	    catch ( Exception ex ){
	        System.out.println(ex);
	    }
	    return date;
	}

	public int checkDayofDate(String s){ //return day value of a string date
		c.setTime(convertStringToDate(s));
		return c.get(Calendar.DAY_OF_WEEK);
	}
	
	public void reset(String s){//if the customer make appointment of other date from current week
   		LocalDate localDate = LocalDate.parse(s, dtf);
   		dateWeek.set(0,dtf.format(localDate.with(DayOfWeek.MONDAY)).toUpperCase());
		dateWeek.set(1,dtf.format(localDate.with(DayOfWeek.TUESDAY)).toUpperCase());
		dateWeek.set(2,dtf.format(localDate.with(DayOfWeek.WEDNESDAY)).toUpperCase());
		dateWeek.set(3,dtf.format(localDate.with(DayOfWeek.THURSDAY)).toUpperCase());
		dateWeek.set(4,dtf.format(localDate.with(DayOfWeek.FRIDAY)).toUpperCase());
		dateWeek.set(5,dtf.format(localDate.with(DayOfWeek.SATURDAY)).toUpperCase());	
   	}

}