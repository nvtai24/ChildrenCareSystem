/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @author Nvtai
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PaymentHistory {
    private int rid;
    private int amount;
    private String transactionDateString;
    private String txnRef;
    private String transactionNo;
}
