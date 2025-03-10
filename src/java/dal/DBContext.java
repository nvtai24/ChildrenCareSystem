/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Nvtai
 */
public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            String user = "root";
            String pass = "1234";
            String url = "jdbc:mysql://localhost:3306/childrencare?useSSL=false";
            

            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void setParameters(PreparedStatement ps, Object... params) throws SQLException {
        for (int i = 0; i < params.length; i++) {
            ps.setObject(i + 1, params[i]);
        }
    }

    public ResultSet executeQuery(String query, Object... params) throws SQLException {
        PreparedStatement ps = null;
        ps = connection.prepareStatement(query);
        setParameters(ps, params);
        return ps.executeQuery();
    }

    public int executeUpdate(String query, Object... params) throws SQLException {
        PreparedStatement ps = connection.prepareStatement(query);
        setParameters(ps, params);
        return ps.executeUpdate();
    }
}
