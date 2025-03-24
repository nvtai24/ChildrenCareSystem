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
import lombok.experimental.FieldDefaults;
import model.auth.User;

/**
 * @author Nvtai
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class Reservation {

    int id;
    int statusId;
    User customer;
    String firstName;
    String lastName;
    LocalDateTime reverseDate;
    String phone;
    String email;
    String note;
    boolean banking;
    ReservationStatus status;
    LocalDateTime createdDate;
    LocalDateTime updatedDate;
    List<ReservationDetail> details;

    int totalQuantity;
    double totalPrice;
    String fullName;
}