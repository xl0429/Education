import java.io.*;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;
public class Cls{
	public static void cls(){
		try {//shortcut key of clear output screen in JCREATOR
		    Robot pressbot = new Robot();
		    pressbot.keyPress(17); // Holds CTRL key.
		    pressbot.keyPress(KeyEvent.VK_SHIFT);// Holds SHIFT key.
		   	pressbot.keyPress(KeyEvent.VK_R); // Holds L key.
		    pressbot.keyRelease(17); // Releases CTRL key.
		    pressbot.keyRelease(KeyEvent.VK_SHIFT);// Releases SHIFT key.
		    pressbot.keyRelease(KeyEvent.VK_R); // Releases L key.
		} catch (Exception ex) {
		   
		}
		System.out.println();
	}
	
		
	public static void promptEnterKey(){
    System.out.println("\n\nPress <ENTER> to continue...");
	    try {
	        System.in.read();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
	
}