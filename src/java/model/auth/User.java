/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.auth;

import java.time.LocalDateTime;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import model.MedicalExamination;
import model.Post;
import model.Profile;
import model.Reservation;
import model.Slider;

/**
 *
 * @author Nvtai
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
    private int id;
    private String username;
    private String password;
    private String email;
    private Role role;
    private Profile profile;
    private boolean status;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    private List<Slider> sliders;
    private List<Post> posts;
    private List<Reservation> reservations;
    private List<MedicalExamination> examinations;
    
}

