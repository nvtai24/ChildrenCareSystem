
import dal.CategoryDAO;
import dal.ServiceDAO;
import model.Category;
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
        
        CategoryDAO list2 = new CategoryDAO();
//        list.updateStatusById(10);
        
       
        for(Category i: list2.list()){
            System.out.println(i.toString());
        }


       
    }
}
