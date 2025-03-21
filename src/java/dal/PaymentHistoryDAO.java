/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.PaymentHistory;
import model.Reservation;

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

    public PaymentHistory getPaymentHistoryInfo(int rid) {

        PaymentHistory ph = null;

        String sql = "SELECT `paymenthistory`.`reservation_id`,\n"
                + "    `paymenthistory`.`amount`,\n"
                + "    `paymenthistory`.`transactiondate`,\n"
                + "    `paymenthistory`.`txnref`,\n"
                + "    `paymenthistory`.`transactiono`\n"
                + "FROM `childrencare`.`paymenthistory`\n"
                + "where reservation_id = ?";

        try {
            ResultSet rs = executeQuery(sql, rid);

            int amount = rs.getInt("amount");
            String transactionDateString = rs.getString("transactiondate");
            String txnRef = rs.getString("txnref");
            String transactionNo = rs.getString("transactiono");

            ph = new PaymentHistory()
                    .builder()
                    .amount(amount)
                    .transactionDateString(transactionDateString)
                    .txnRef(txnRef)
                    .transactionNo(transactionNo)
                    .build();

        } catch (SQLException ex) {
            Logger.getLogger(PaymentHistoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ph;
    }

}
