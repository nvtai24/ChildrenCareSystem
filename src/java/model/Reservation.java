/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Reservation {
    private int id;
    private User customer;
    private ReservationStatus status;
    private LocalDateTime reservedDate;
    private String notes;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    private List<MedicalExamination> examinations;
    private List<ReservationDetail> reservationDetails;
}
