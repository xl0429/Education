package dsa_assignment.UI;

import dsa_assignment.adt.BinarySearch.*;
import dsa_assignment.entity.Student;
import dsa_assignment.helper.FileHandling;
import dsa_assignment.helper.JavaxSwingHelper;
import dsa_assignment.helper.TextAreaOutputStream;
import java.io.PrintStream;
import java.util.Scanner;

public class TreeSearch extends javax.swing.JFrame {

    JavaxSwingHelper j = new JavaxSwingHelper();

    public TreeSearch() {
        initComponents();
        this.setLocationRelativeTo(null);
        this.setResizable(false);
        jTextAreaSearched.setEditable(false);
        // catch the enter key in the jTextFieldSearchStr and 
        //  perform an search click on the jButtonSearch
        JavaxSwingHelper j = new JavaxSwingHelper();
        j.enterKeyControl(jTextFieldSearchStr, jButtonSearch);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane2 = new javax.swing.JScrollPane();
        jEditorPane1 = new javax.swing.JEditorPane();
        jPanel1 = new javax.swing.JPanel();
        jLabelTItle = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTextAreaSearched = new javax.swing.JTextArea();
        jButtonBack = new javax.swing.JButton();
        jTextFieldSearchStr = new javax.swing.JTextField();
        jButtonSearch = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();

        jScrollPane2.setViewportView(jEditorPane1);

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jLabelTItle.setFont(new java.awt.Font("Tahoma", 1, 24)); // NOI18N
        jLabelTItle.setText("Tree Search");

        jTextAreaSearched.setColumns(20);
        jTextAreaSearched.setFont(new java.awt.Font("MS Gothic", 0, 13)); // NOI18N
        jTextAreaSearched.setRows(5);
        jScrollPane1.setViewportView(jTextAreaSearched);

        jButtonBack.setText("Back");
        jButtonBack.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonBackActionPerformed(evt);
            }
        });

        jButtonSearch.setText("Search");
        jButtonSearch.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonSearchActionPerformed(evt);
            }
        });

        jLabel1.setForeground(new java.awt.Color(102, 102, 102));
        jLabel1.setText("Search for: ID, First Name, Last Name");

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jButtonBack)
                .addGap(426, 426, 426))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(298, 298, 298)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel1)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(jLabelTItle)
                            .addComponent(jTextFieldSearchStr, javax.swing.GroupLayout.PREFERRED_SIZE, 223, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jButtonSearch)))
                .addContainerGap(314, Short.MAX_VALUE))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1)
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(32, 32, 32)
                .addComponent(jLabelTItle)
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jTextFieldSearchStr, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButtonSearch))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 27, Short.MAX_VALUE)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 256, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(jButtonBack)
                .addGap(22, 22, 22))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(45, Short.MAX_VALUE)
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(40, 40, 40))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addGap(0, 22, Short.MAX_VALUE)
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButtonBackActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonBackActionPerformed
        j.back(this);
    }//GEN-LAST:event_jButtonBackActionPerformed

    private void jButtonSearchActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonSearchActionPerformed

        if(jTextFieldSearchStr.getText().length() == 0){//ensure searchSrting has value
            //clear jTextAreaSearched
            jTextAreaSearched.selectAll();
            jTextAreaSearched.replaceSelection("");
        }else{
            jTextAreaSearched.selectAll();
            jTextAreaSearched.replaceSelection("");
            PrintStream out = new PrintStream( new TextAreaOutputStream( jTextAreaSearched ) );
            //output to JTextArea
            System.setOut( out );
            System.setErr( out );
            treeSearch();

        }
    }//GEN-LAST:event_jButtonSearchActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(TreeSearch.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(TreeSearch.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(TreeSearch.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(TreeSearch.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new TreeSearch().setVisible(true);
            }
        });
    }
    public void treeSearch(){
        FileHandling f =new FileHandling();
        BinarySearchInterface<String> bTree = new BinarySearch<>();
        Scanner input = new Scanner(System.in);
        String tree = jTextFieldSearchStr.getText();
        tree = tree.toUpperCase();
        
        Student stud = new Student();

       queueInterface <Student> q = f.fileToQueue();
       queueInterface <Student> tmp = f.fileToQueue();

       int size = q.size();
       String [] a =new String[size];
       String [] b =new String[size];
       String [] c =new String[size];
       
        for(int i=0; i< size;i++){
            stud = q.dequeue();
            a[i] = stud.getfName().toUpperCase();
            b[i] = stud.getlName().toUpperCase();
            c[i] = stud.getId().toUpperCase();
        }
        for(int i = 0;i< size;i++){
            bTree.add(a[i]);
            bTree.add(b[i]);
            bTree.add(c[i]);
        }
       
        Student s2 = new Student();
        
        if(bTree.contains(tree)){
            System.out.print(stud.headerText());
            for(int i=0;i<size;i++){
                stud =tmp.dequeue();
                if(bTree.getEntry(tree).equals(stud.getfName().toUpperCase())||
                        bTree.getEntry(tree).equals(stud.getlName().toUpperCase())||
                        bTree.getEntry(tree).equals(stud.getId().toUpperCase())){
                    s2 = stud;
                     break;
                }

            }
            System.out.print(String.format("%-5s%s",1,s2));


        }
        else{
            System.out.println("Record is NOT Existed");
        }

       
    }
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButtonBack;
    private javax.swing.JButton jButtonSearch;
    private javax.swing.JEditorPane jEditorPane1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabelTItle;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTextArea jTextAreaSearched;
    private javax.swing.JTextField jTextFieldSearchStr;
    // End of variables declaration//GEN-END:variables
}
