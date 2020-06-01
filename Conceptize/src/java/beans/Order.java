/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

/**
 *
 * @author Flygo
 */
public class Order implements Serializable {
    private int oid;
    private int pid;
    private String uid;
    private String creationDate;
    private static Connection conn = DBConnector.getConn();
    
    Order() {
        this.oid = 0;
        this.pid = 0;
        this.uid = null;
        this.creationDate = null;
    }
    
    Order(int oid, int pid, String uid, String creationDate) {
        this.oid = oid;
        this.pid = pid;
        this.uid = uid;
        this.creationDate = creationDate;
    }
    
    public int getOid() {
        return this.oid;
    }
    
    public int getPid() {
        return this.pid;
    }
    
    public String getUid() {
        return this.uid;
    }
    
    public String getMakedate() {
        return this.creationDate;
    }
    
    public void setOid(int oid) {
        this.oid = oid;
    }
    
    public void setPid(int pid) {
        this.pid = pid;
    }
    
    public void setUid(String uid) {
        this.uid = uid;
    }
    
    public void setMakedate(String makedate) {
        this.creationDate = makedate;
    }
    
    public static int orderExists(String pid, String uid) {
        conn = DBConnector.getConn();
        String checkStmt = "select * from apollo7_conceptize.order where pid = ? and uid = ?;";
        ResultSet rs;
        
        try {
            int ipid = Integer.parseInt(pid);
            PreparedStatement ps = conn.prepareStatement(checkStmt);
            ps.setInt(1,ipid);
            ps.setString(2,uid);

            rs = ps.executeQuery();

            // check if user has already purchased the item. if so, return order id here
            if (rs.next())
                return rs.getInt("oid");     
        else
            return 0;
        } catch (Exception e) {
            return 0;
        }
    }
    
    public static Order getOrder(int oid) {
        conn = DBConnector.getConn();
        String stmt = "select * from apollo7_conceptize.order where oid = ?;";
        Order order = new Order(); 
        try {
            PreparedStatement ps = conn.prepareStatement(stmt);
            ps.setInt(1,oid);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                order.setOid(rs.getInt("oid"));
                order.setPid(rs.getInt("pid"));
                order.setUid(rs.getString("uid"));
                order.setMakedate(rs.getString("creation_date"));
                
                return order;
            } else {
                return null;
            }
            
        } catch (Exception e) {
            return new Order();
        }
    }
    
    public static int makeOrder(String uid, int pid) {
        conn = DBConnector.getConn();
        String countStmt = "select * from apollo7_conceptize.order;";
        String stmt = "insert into apollo7_conceptize.order (pid,uid,creation_date) values (?,?,?);";
        ResultSet rs;
        User user = User.getUser(uid);
        Product product = Product.getProduct(pid);
        int count = 1;
        
        // check if both user and product exists
        if (user != null && product != null) {
            if (user.getCoins() >= product.getPrice()) {
                
                try {
                    PreparedStatement ps;
                    // check if user has already purchased the item. if so, return order id here
                    if (orderExists(new Integer(pid).toString(),uid) > 0)
                        return orderExists(new Integer(pid).toString(),uid);
                    
                    // count oids 
                    ps = conn.prepareStatement(countStmt);
                    rs = ps.executeQuery();
                    
                    while (rs.next())
                        count++;

                    user.setCoins(user.getCoins() - product.getPrice());
                    
                    User seller = User.getUser(product.getUid());
                    seller.setCoins(seller.getCoins() + product.getPrice());
                    
                    seller.save();

                    Order newOrder = new Order();

                    newOrder.pid = pid;
                    newOrder.uid = uid;
                    newOrder.creationDate = new Date().toLocaleString();
                    newOrder.oid = count;
                    
                    ps = conn.prepareStatement(stmt);
                    ps.setInt(1,pid);
                    ps.setString(2,uid);
                    ps.setString(3,newOrder.creationDate);
                    ps.executeUpdate();
                    
                    user.save();
                    
                    return count;
                    
                } catch (Exception e) {
                    System.out.println("Exception has occurred");
                    e.printStackTrace();
                    return 0;
                }
                
            } else {
                System.out.println("User is poor haha");
                return 0; // user does not have enough money
            }
        } else {
            System.out.println("Product does not exist");
            return 0; // user or product does not exist
        }
    }
}
