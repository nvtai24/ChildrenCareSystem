/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.auth;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;
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
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class User {
    int id;
    String username;
    String password;
    String email;
    Role role;
    Profile profile;
    boolean status;
    boolean emailVerified;
    Timestamp tokenExpiration;
    LocalDateTime createdDate;
    LocalDateTime updatedDate;
    List<Slider> sliders;
    List<Post> posts;
    List<Reservation> reservations;
    String avatar;
    String verificationToken;
    boolean verified;
    String firstname;
    String lastname;
}