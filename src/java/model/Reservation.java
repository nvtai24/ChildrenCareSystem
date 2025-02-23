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
    private String firstName;
    private String lastName;
    private LocalDateTime reverseDate;
    private String phone;
    private String email;
    private String note;
    private boolean banking;
    private ReservationStatus status;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    private List<ReservationDetail> details;
    private List<MedicalExamination> examinations;
}
