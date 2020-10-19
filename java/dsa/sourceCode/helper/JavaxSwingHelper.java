package dsa_assignment.helper;

import dsa_assignment.MainPage;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JTextField;

public class JavaxSwingHelper {
    //allow pressing enter to perform search button click
    public void enterKeyControl(JTextField j,JButton b ){
      j.addKeyListener(new KeyAdapter() {
         public void keyPressed(KeyEvent e) {
            if (e.getKeyCode()==KeyEvent.VK_ENTER) {
               b.doClick();
            }
         }
      });
    }
    //go back to main page
    public void back(JFrame f){
        f.setVisible(false);
        MainPage main = new MainPage();
        main.setVisible(true);
    }
    
    class MyButton extends JButton{
        public int index;
        MyButton(){super();}
        MyButton(int index){super();this.index=index;}
}
    
    
}
