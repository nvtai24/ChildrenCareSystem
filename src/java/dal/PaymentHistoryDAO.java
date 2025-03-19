/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.PaymentHistory;

/**
 *
 * @author Nvtai
 */
public class PaymentHistoryDAO extends DBContext {

    public void insertPayment(PaymentHistory p) {
        String sql = "INSERT INTO `childrencare`.`paymenthistory`\n"
                + "(`reservation_id`,\n"
                + "`amount`,\n"
                + "`transactiondate`,\n"
                + "`txnref`,\n"
                + "`transactiono`)\n"
                + "VALUES\n"
                + "(?,?,?,?,?)";

        try {
            executeUpdate(sql, p.getRid(), p.getAmount(), p.getTransactionDateString(), p.getTxnRef(), p.getTransactionNo());
        } catch (SQLException ex) {
            Logger.getLogger(PaymentHistoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
