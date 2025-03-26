/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class Post {
    int id;
    User author;
    String title;
    String content;
    String thumbnail;
    String username;
    String briefInfo;
    boolean status;
    LocalDateTime createdDate;
    LocalDateTime updatedDate;
    List<Label> labels;
    LocalDate createdDateOnly; // Chỉ ngày
    LocalTime createdTimeOnly;
}