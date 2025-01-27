
import dal.ServiceDAO;
import model.Service;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Admin
 */
public class test {
    public static void main(String[] args) {
        
        ServiceDAO list = new ServiceDAO();
        
        
//        list.updateStatusById(10);
        
       
        for (Service arg : list.getListByName("heal")) {
            System.out.println(arg.toString());
        }


       
    }
}
