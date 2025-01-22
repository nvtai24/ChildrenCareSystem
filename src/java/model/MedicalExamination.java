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
public class MedicalExamination {
    private int id;
    private Reservation reservation;
    private User staff;
    private LocalDateTime examinationDate;
    private String diagnosis;
    private String notes;
    private boolean status;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    private List<MedicalPrescription> prescriptions;
}
