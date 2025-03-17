/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import at.favre.lib.crypto.bcrypt.BCrypt;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

/**
 *
 * @author admin
 */
public class PasswordUtil {

    
    private static final int ITERATIONS = 65536;
    private static final int KEY_LENGTH = 512; 
    
    public static String hashPassword(String password) throws Exception {
        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, ITERATIONS, KEY_LENGTH);
        SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA512");
        byte[] hashedPassword = skf.generateSecret(spec).getEncoded();
        return Base64.getEncoder().encodeToString(salt) + "$" + Base64.getEncoder().encodeToString(hashedPassword);
    }

    public static boolean verifyPassword(String enteredPassword, String storedPassword) throws Exception {
        String[] parts = storedPassword.split("\\$");
        byte[] salt = Base64.getDecoder().decode(parts[0]);
        byte[] storedHashedPassword = Base64.getDecoder().decode(parts[1]);

        PBEKeySpec spec = new PBEKeySpec(enteredPassword.toCharArray(), salt, ITERATIONS, storedHashedPassword.length * 8);
        SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA512");
        byte[] hashedPassword = skf.generateSecret(spec).getEncoded();

        return java.util.Arrays.equals(storedHashedPassword, hashedPassword);
    }
    public static String toSHA1(String password){
        String salt = "kasndkcajsciauw@asdjC";
        String result = null;
        
        password = password + salt;
        try{
            byte[] dataBytes = password.getBytes("UTF-8");
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            result = Base64.getEncoder().encodeToString(md.digest(dataBytes));
        } catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }
}
