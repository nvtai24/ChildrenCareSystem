/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.auth;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import jakarta.activation.DataHandler;
import jakarta.activation.DataSource;
import jakarta.activation.FileDataSource;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class OAuth2EmailService {

    private static final String SMTP_SERVER = "smtp.gmail.com";
    private static final int SMTP_PORT = 587;
    private static final String EMAIL_FROM = "dominhanh235@gmail.com";
    private static final String ACCESS_TOKEN = "ya29.a0AXeO80TQy31TVVGhpNqNxuQB1AyEmIkmMlt5svwpgJq3om7ASq52HwBZ6PJElN8yTHU58xL4GPt66n4tcwpAAxCs5yDrJ5uQ_CM3vr0zIMsHMZ0AkW8O4eoLyTjLemWgr5zOoEzbKn2FkP_IwbZ_CLt1Fz-QOLROdMMVCEGJaCgYKASkSARASFQHGX2MiqpHxTyxZC0xdGB6wylzslQ0175";  // Lấy từ OAuth2

    public static void sendVerificationEmail(String to, String verificationLink) {
        try {
            Properties properties = new Properties();
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.host", SMTP_SERVER);
            properties.put("mail.smtp.port", SMTP_PORT);

            Session session = Session.getInstance(properties, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_FROM, ACCESS_TOKEN);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Verify Your Email");
            message.setText("Click the link below to verify your account:\n" + verificationLink);

            Transport transport = session.getTransport("smtp");
            transport.connect("smtp.gmail.com", EMAIL_FROM, ACCESS_TOKEN);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
            System.out.println("Email sent successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
