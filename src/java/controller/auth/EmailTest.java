/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.auth;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailTest {
    public static void main(String[] args) {
        String to = "dominhchi235@gmail.com";
        String from = "dominhanh235@gmail.com";
        String host = "smtp.gmail.com";

        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        properties.setProperty("mail.smtp.port", "587");
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", "true");

        Session session = Session.getDefaultInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, "ya29.a0AXeO80SRZLGaHntCBkUsunr-gG-V8z8Utsu6wkLMGS33Z_KaxvYi_JOf4E9jk0SqEWP1Z0eKkGm7g1zY7I8dJWi0EW-GitL92xGxAPyuGiAU7JOz8z5QWtEglllOb4p5MFq-AbvicHgajVaBXZeXcrL0hqXi6-LrbGigAdZ6aCgYKASkSARASFQHGX2Mi3wGZmc7XfHeYFGGEjY01Mw0175");
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("Test Email from Java");
            message.setText("If you receive this, your email setup is working!");

            Transport.send(message);
            System.out.println("Email sent successfully!");
        } catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }
}
