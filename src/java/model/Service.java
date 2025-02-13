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

/**
 *
 * @author Nvtai
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Service {
    private int id;
    private Category category;
    private String name;
    private String description;
    private String briefInfo;
    private double price;
    private double discount;
    private String thumbnail;
    private double status;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    private List<ReservationDetail> reservationDetails;
    
    
}
