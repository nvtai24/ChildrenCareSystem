/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

/**
 *
 * @author Nvtai
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class Feedback {
    private int id;
    private ReservationDetail reservationDetail;
    private int reservationDetailId;
    private int rating;
    private String comment;
    private boolean status;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    private String avatar;
}