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
public class Setting {
    private int id;
    private SettingType settingType;
    private String settingValue;
    private String description;
    private boolean status;
}
