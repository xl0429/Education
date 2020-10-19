import java.util.*;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

/*
 Transaction Code	Checking								DISCOUNT
TI1031				Checking for national day				100%
TW1037				Checking for wax times  < 5 			-
TW1015				Checking for wax times 5-7				10%
TW1024				Checking for wax times  equal to 8 & 9	30%
TW1010				Checking for wax times euqal to 10 		100%
 */

public class Payment extends Transaction{
	
	FileHandling f = new FileHandling("payment.txt");
	private int num = f.getLastNum();
	private String payId = "P" + ++num;
	private String dateTime;
	private double laborRate = 15; // 1 hr workman fee
	private double hr; // hour the tech work with
	private double laborFee;
	private List<String> sDesc = new ArrayList<String>(); //service descriptoin
	private List<Double> sPrice = new ArrayList<Double>(); //for each service;
	private double tPrice; // total price for service
	private double grantTotal;
	private double payAmount;
	private double discountRate;
	private double discountPrice;//discount for wax
	private double balance;
	private String date;
	
	Scanner sc1 = new Scanner(System.in);//solve nextLine buffer problem, using 2 different scanner object
	Scanner sc2 = new Scanner(System.in);
	private static final DateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
		
	//construtor
	public Payment(){
	}
	
	//setter
    public void setPayId(String payId) {
        this.payId = payId;
    }
    public void setDateTime(String dateTime){
    	this.dateTime = dateTime;
    }
    public void setHr(double hr) {
    	while(hr < 0 || hr > 10)
  			hr= Validation.readDoubleValid(String.format("%-25s: ", "Hour(s) [1 - 10]"), "hour(s)");
        this.hr = hr;
    }
	public void setsDesc(List<String> sDesc) {
        this.sDesc = sDesc;
    }
    public void setsPrice(List<Double> price) {
        this.sPrice = price;
    }
    public void settPrice(double tPrice) {
        this.tPrice = tPrice;
    }   
    public void setLaborFee(double laborFee) {
        this.laborFee = laborFee;
    }
    public void setGrantTotal(double grantTotal) {
        this.grantTotal = grantTotal;
    }
    
   	public void setPayAmount(double payAmount){
   		double pay = getGrantTotal();
   		if(getTransCode().substring(0,2).equals("TW"))//DISCOUNT when wax
			pay = discountPrice;
   		while(payAmount < pay){
   			payAmount = Validation.readDoubleValid(String.format("%-35s", "*Not sufficient*. Pay Amount : "), "pay amount");
   		}
   		this.payAmount = payAmount;
   	}
	public void setDiscountRate(double discountRate){
		this.discountRate = discountRate;
	}
	public void setDiscountPrice(double discountPrice){
		this.discountPrice = discountPrice;
	}
	public void setBalance(double balance){
		this.balance = balance;
	}
	
    //getter
    public String getPayId() {
        return payId;
    }
    public String getDateTime(){
    	return dateTime;
    }
    public double getLaborRate(){
    	return laborRate;
    }
    public double getHr() {
        return hr;
    }
	public List<String> getsDesc() {
        return sDesc;
    }
    public List<Double> getsPrice() {
        return sPrice;
    }
	public double gettPrice() {
        return tPrice;
    }  
    public double getLaborFee() {
        return laborFee;
    }
    public double getGrantTotal() {
        return grantTotal;
    }
   	public double getPayAmount(){
   		return payAmount;
   	}
   	public double getDiscountPrice(){
		return discountPrice;
	}	
	public double getDiscountRate(){
		return discountRate;
	}
	public double getBalance(){
		return balance;
	}	
	
	public double calLaborFee(){
		return hr * laborRate;
	}
	public double calGrantTotal(){
		return laborFee + tPrice;
	}
	public double calBalance(){
		if(getTransCode().contains("TW"))
			return payAmount - discountPrice;
		else
			return payAmount - grantTotal;
	}
	public double calDiscountPrice(){
		return grantTotal * (1-discountRate);
	}
	public void discountRate(){// wax discount
		int count = f.countWax(getCustId());
		if(count % 10 == 0)
			setDiscountRate(1);
		else if(count % 10 == 8 || count % 10 == 9 )
			setDiscountRate(0.3);
		else if(count % 10 >= 5 && count % 10 <= 7)
			setDiscountRate(0.1);
		else
			setDiscountRate(0);
	}
	
	public String paymentToFile(){
		if(discountRate > 0)
			setGrantTotal(discountPrice);
		return payId + "\t" + dateTime +"\t" + getCustId() + "\t" + getTransCode() +"\t" +  grantTotal;
	}
	public String serviceToFile(){
		return payId + "\t" + sDesc + "\t" +sPrice + "\t"  + tPrice;
	}
	
	public void addService(){
		List<String> serviceDesc = new ArrayList<String>();
		List<Double> servicePrice = new ArrayList<Double>();
		double total = 0; // total price for all service
		int count =0;	
		System.out.println("\n**Hit <enter> in empty service desc to terminate this section.**");
		do{
			System.out.println("\nService " + (count+1));
			System.out.printf("%-25s: ", "Description");
			serviceDesc.add(sc1.nextLine());
			if(!serviceDesc.get(serviceDesc.size()-1).equals("")){
				servicePrice.add(Validation.readDoubleValid("price"));
				total += servicePrice.get(servicePrice.size()-1);	
			}				
			count++;
		}while(!serviceDesc.get(serviceDesc.size()-1).equals("")); // when the user press enter twice this loop will end
		serviceDesc.remove(""); // remove last element, ""
		
		//using setter to set whole arraylist 
		setsDesc(serviceDesc);
		setsPrice(servicePrice);
		
		settPrice(total);	
		savetoFile("service.txt", serviceToFile());//save to service file	
	}
	public String toStringDesc(){
    	return String.join(",", getsDesc()); 
    }
    public String toStringPrice(){
    	return String.join(",", (getsPrice()+"")); 
    }

	public void addPayment(){	
		Date date = new Date();
		setDateTime(sdf.format(date).toUpperCase());
        System.out.println(getDateTime()+"\n-----------------");
        f.displayCertainContent(getDateTime().substring(0,11), "transaction.txt");//display all today appointment
        
		System.out.printf("\n\n%-25s: ", "Transaction Code");
		String tCode = sc2.next().toUpperCase().trim();
		
		if(f.readContentInFile(tCode, "transaction.txt")){//check is whether the transaction code is inside the transaction.txt
			
			if(!f.readContentInFile(tCode, "payment.txt")){//if the transaction code in payment.txt means to payment is clear
				
				displayTrans();
				
				if(getDate().contains("31-AUG") && getTransCode().contains("TI")){//inspection in national day
					System.out.println("\n\nPayment is not needed for inspection in national day");
					generateReceipt();
					savetoFile("payment.txt", paymentToFile()); //SAVE TO PAYMENT FILE
				}else{
					System.out.println("\nPayment Id : " + getPayId());
					setHr(Validation.readDoubleValid("Hour(s) for labor worked : ", "hour(s)"));
					setLaborFee(calLaborFee());
					addService();
					setGrantTotal(calGrantTotal());
					if(getTransCode().substring(0,2).equals("TW")){
						discountRate();
						setDiscountPrice(calDiscountPrice());
					}
						
					generateReceipt();
					
				
					if(getDiscountRate() != 1)
						setPayAmount(Validation.readDoubleValid(String.format("%-36s", "\nPay Amount          :"), "pay amount"));
					setBalance(calBalance());
						
					generateReceipt();
					savetoFile("payment.txt", paymentToFile()); //SAVE TO PAYMENT FILE
				}
			}else
				System.out.println("\nPayment for " + tCode + " is cleared.");
			
		}else{
			System.out.println("\n"+tCode + " is not found");
		}
		
	}
	
	public void generateReceipt(){
		List<String> serviceDesc =getsDesc();
		List<Double> servicePrice = getsPrice();
		if(getPayAmount() == 0)
			System.out.println("\nPayment......\n-------------");
		else
			System.out.println("\nPayment Receipt\n---------------");
		System.out.printf("%-20s: %s\n%-20s: %s\n%-20s: %s\n%-20s: %s\n", "Transaction Code", getTransCode(),"Customer Id", getCustId(), "Car Plate No.", getCarPlate(), "Technician Id", getTechId());
		System.out.printf("%-20s: %s\n%-20s: %s\n", "Date", getDate(), "Time", getTime());
		System.out.println("----------------------------------------");
		System.out.printf("%-30s%10s\n", "Work Hour           : ", getHr());
		System.out.println("----------------------------------------");
		System.out.printf("%-30s%10s\n", "Service", "Price(RM)");	
		for(int i =0;i < sDesc.size(); i++)
			System.out.printf("%-30s%10.2f\n", getsDesc().get(i), getsPrice().get(i));
		System.out.println("----------------------------------------");
		System.out.printf("%-30s%10.2f\n", "Total Service Price : ",gettPrice())	;
		System.out.printf("%-30s%10.2f\n", "Labor Fee           : ", getLaborFee());
		System.out.println("----------------------------------------");
		double price = getGrantTotal();
		System.out.printf("%-30s%10.2f\n", "Grant Total         : ", price);	
		if(getDiscountRate() > 0 && getTransCode().substring(0,2).equals("TW")){//only wax has discount
			System.out.printf("%-30s%10.2f\n",String.format("Discount Price(" + Math.round(getDiscountRate()*100) +"%%" +") : "), getDiscountPrice());	
		}
		if(getPayAmount() != 0 || getDiscountRate() == 1){
			System.out.printf("%-30s%10.2f\n", "Pay Amount          : ", getPayAmount());
			System.out.println("----------------------------------------");
			System.out.printf("%-30s%10.2f\n", "Balance             : ", getBalance());	
		}
		
		
	}
	
	public void displayTrans(){
    	String transaction = f.getTransaction();
        String[] details = transaction.split("\t");
        setTransCode(details[0]);
        setCustId(details[1]);
        setCarPlate(details[2]);
        setDate(details[3]);
        setTime(details[4]);
        setTechId(details[5]);
        super.displayTransaction();
       	
    }  	
	
	public void checkDailyPayment(){
		System.out.printf("%-25s: ", "Date(dd-MMM-yyyy)");
		String s = sc.next();		
		if(f.readContentInFile(s, "payment.txt")){
			System.out.println("\n\nPayment in " + s + "\n----------------------------");
			System.out.println("PayId	Date        Time 	CustId	TranId  Price(RM)");
			System.out.println("-----	----        ---- 	------	------  --------");
			f.displayCertainContent(s, "payment.txt");
			System.out.println("\nTotal payment in " + s + ": RM " + f.gettPayment());
		}else
			System.out.println("\n\n*" + s + " is not found.*");
		
	}
	
	public void checkMonthlyPayment(){
		System.out.printf("%-25s: ", "Month(MMM)");
		String s = sc.next();		
		s = s.substring(0,3).toUpperCase();
		if(f.readContentInFile(s, "payment.txt")){
			System.out.println("\n\nPayment in " + s + "\n----------------------------");
			System.out.println("PayId	Date        Time 	CustId	TranId  Price(RM)");
			System.out.println("-----	----        ---- 	------	------  --------");
			f.displayCertainContent(s, "payment.txt");
			System.out.println("\nTotal payment in " + s + ": RM " + f.gettPayment());
			
		}else
			System.out.println("\n\n*" + s + " is not found.*");
	}
	
	
}

