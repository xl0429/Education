/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dsa_assignment;
import dsa_assignment.UI.*;
import dsa_assignment.helper.*;
public class MainPage extends javax.swing.JFrame {

    FileHandling f = new FileHandling();
    
    public MainPage() {
        initComponents();
         this.setLocationRelativeTo(null);
         this.setResizable(false);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jButtonFilter = new javax.swing.JButton();
        jButtonDuplicateCheck = new javax.swing.JButton();
        jButtonTreeSearch = new javax.swing.JButton();
        jButtonIndexing = new javax.swing.JButton();
        jButtonSorting = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jButtonAddStudent = new javax.swing.JButton();
        jButtonDisplayAllStud = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jButtonFilter.setBackground(new java.awt.Color(204, 255, 204));
        jButtonFilter.setFont(new java.awt.Font("Tahoma", 0, 15)); // NOI18N
        jButtonFilter.setText("Filter");
        jButtonFilter.setMaximumSize(new java.awt.Dimension(125, 40));
        jButtonFilter.setMinimumSize(new java.awt.Dimension(125, 40));
        jButtonFilter.setPreferredSize(new java.awt.Dimension(125, 40));
        jButtonFilter.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonFilterActionPerformed(evt);
            }
        });

        jButtonDuplicateCheck.setBackground(new java.awt.Color(204, 255, 204));
        jButtonDuplicateCheck.setFont(new java.awt.Font("Tahoma", 0, 15)); // NOI18N
        jButtonDuplicateCheck.setText("Duplicate Check");
        jButtonDuplicateCheck.setMaximumSize(new java.awt.Dimension(125, 25));
        jButtonDuplicateCheck.setMinimumSize(new java.awt.Dimension(125, 25));
        jButtonDuplicateCheck.setPreferredSize(new java.awt.Dimension(125, 40));
        jButtonDuplicateCheck.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonDuplicateCheckActionPerformed(evt);
            }
        });

        jButtonTreeSearch.setBackground(new java.awt.Color(204, 255, 204));
        jButtonTreeSearch.setFont(new java.awt.Font("Tahoma", 0, 15)); // NOI18N
        jButtonTreeSearch.setText("Tree Search");
        jButtonTreeSearch.setMaximumSize(new java.awt.Dimension(125, 40));
        jButtonTreeSearch.setMinimumSize(new java.awt.Dimension(125, 40));
        jButtonTreeSearch.setPreferredSize(new java.awt.Dimension(125, 40));
        jButtonTreeSearch.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonTreeSearchActionPerformed(evt);
            }
        });

        jButtonIndexing.setBackground(new java.awt.Color(204, 255, 204));
        jButtonIndexing.setFont(new java.awt.Font("Tahoma", 0, 15)); // NOI18N
        jButtonIndexing.setText("Indexing");
        jButtonIndexing.setMaximumSize(new java.awt.Dimension(125, 40));
        jButtonIndexing.setMinimumSize(new java.awt.Dimension(125, 40));
        jButtonIndexing.setPreferredSize(new java.awt.Dimension(125, 40));
        jButtonIndexing.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonIndexingActionPerformed(evt);
            }
        });

        jButtonSorting.setBackground(new java.awt.Color(204, 255, 204));
        jButtonSorting.setFont(new java.awt.Font("Tahoma", 0, 15)); // NOI18N
        jButtonSorting.setText("Sorting");
        jButtonSorting.setMaximumSize(new java.awt.Dimension(125, 40));
        jButtonSorting.setMinimumSize(new java.awt.Dimension(125, 40));
        jButtonSorting.setPreferredSize(new java.awt.Dimension(125, 40));
        jButtonSorting.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonSortingActionPerformed(evt);
            }
        });

        jLabel1.setFont(new java.awt.Font("Tahoma", 1, 36)); // NOI18N
        jLabel1.setText("Algorithms");

        jButtonAddStudent.setText("Add Student");
        jButtonAddStudent.setMaximumSize(new java.awt.Dimension(125, 40));
        jButtonAddStudent.setMinimumSize(new java.awt.Dimension(125, 40));
        jButtonAddStudent.setPreferredSize(new java.awt.Dimension(125, 40));
        jButtonAddStudent.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonAddStudentActionPerformed(evt);
            }
        });

        jButtonDisplayAllStud.setText("Display All Student");
        jButtonDisplayAllStud.setMaximumSize(new java.awt.Dimension(125, 40));
        jButtonDisplayAllStud.setMinimumSize(new java.awt.Dimension(125, 40));
        jButtonDisplayAllStud.setPreferredSize(new java.awt.Dimension(125, 40));
        jButtonDisplayAllStud.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonDisplayAllStudActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                .addContainerGap(57, Short.MAX_VALUE)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                        .addComponent(jButtonFilter, javax.swing.GroupLayout.PREFERRED_SIZE, 135, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(49, 49, 49)
                        .addComponent(jButtonDuplicateCheck, javax.swing.GroupLayout.PREFERRED_SIZE, 137, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(39, 39, 39)
                        .addComponent(jButtonTreeSearch, javax.swing.GroupLayout.PREFERRED_SIZE, 120, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(89, 89, 89))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addGap(202, 202, 202))))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(128, 128, 128)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jButtonIndexing, javax.swing.GroupLayout.PREFERRED_SIZE, 121, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButtonAddStudent, javax.swing.GroupLayout.PREFERRED_SIZE, 150, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(71, 71, 71)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jButtonSorting, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButtonDisplayAllStud, javax.swing.GroupLayout.PREFERRED_SIZE, 150, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1)
                .addGap(27, 27, 27)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jButtonFilter, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButtonDuplicateCheck, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButtonTreeSearch, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jButtonSorting, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButtonIndexing, javax.swing.GroupLayout.PREFERRED_SIZE, 42, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 28, Short.MAX_VALUE)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jButtonAddStudent, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButtonDisplayAllStud, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(22, 22, 22))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(26, 26, 26)
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButtonFilterActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonFilterActionPerformed
        this.setVisible(false);
        Filter f = new Filter();
        f.setVisible(true);     
    }//GEN-LAST:event_jButtonFilterActionPerformed

    private void jButtonTreeSearchActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonTreeSearchActionPerformed
        this.setVisible(false);
        TreeSearch t = new TreeSearch();
        t.setVisible(true); 
    }//GEN-LAST:event_jButtonTreeSearchActionPerformed

    private void jButtonAddStudentActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonAddStudentActionPerformed
        this.setVisible(false);
        addStudent addStud = new addStudent();
        addStud.setVisible(true);
    }//GEN-LAST:event_jButtonAddStudentActionPerformed

    private void jButtonDisplayAllStudActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonDisplayAllStudActionPerformed
       this.setVisible(false);
       DisplayAllStudent d = new DisplayAllStudent();
       d.setVisible(true);
    }//GEN-LAST:event_jButtonDisplayAllStudActionPerformed

    private void jButtonDuplicateCheckActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonDuplicateCheckActionPerformed
        //this.setVisible(false);
        //DuplicationCheck d = new DuplicationCheck();
        //d.setVisible(true);
    }//GEN-LAST:event_jButtonDuplicateCheckActionPerformed

    private void jButtonIndexingActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonIndexingActionPerformed
        this.setVisible(false);
        Indexing i = new Indexing();
        i.setVisible(true);
    }//GEN-LAST:event_jButtonIndexingActionPerformed

    private void jButtonSortingActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonSortingActionPerformed
        this.setVisible(false);
        Sorting s = new Sorting();
        s.setVisible(true);
    }//GEN-LAST:event_jButtonSortingActionPerformed

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
            java.util.logging.Logger.getLogger(MainPage.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(MainPage.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(MainPage.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(MainPage.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new MainPage().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButtonAddStudent;
    private javax.swing.JButton jButtonDisplayAllStud;
    private javax.swing.JButton jButtonDuplicateCheck;
    private javax.swing.JButton jButtonFilter;
    private javax.swing.JButton jButtonIndexing;
    private javax.swing.JButton jButtonSorting;
    private javax.swing.JButton jButtonTreeSearch;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel1;
    // End of variables declaration//GEN-END:variables
}