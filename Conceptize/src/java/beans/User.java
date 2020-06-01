package beans;

import java.io.Serializable;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

public class User implements Serializable {
    
    private String uid;
    private String pwd;
    private String name;
    private int coins;
    private String regdate;
    private String about;
    private String interests;
    private String pic_id;
    private static Connection conn = DBConnector.getConn();
    
    public User() {
        this.uid = null;
        this.pwd = null;
        this.name = "";
        this.coins = 10000;
        this.regdate = null;
        this.about = "";
        this.interests = "";
        this.pic_id = "http://s3.amazonaws.com/37assets/svn/765-default-avatar.png";
    }
    
    public static String hash256(String input) { 
        try { 
            // getInstance() method is called with algorithm SHA-512 
            MessageDigest md = MessageDigest.getInstance("SHA-512"); 
  
            // digest() method is called 
            // to calculate message digest of the input string 
            // returned as array of byte 
            byte[] messageDigest = md.digest(input.getBytes()); 
  
            // Convert byte array into signum representation 
            BigInteger no = new BigInteger(1, messageDigest); 
  
            // Convert message digest into hex value 
            String hashtext = no.toString(16); 
  
            // Add preceding 0s to make it 32 bit 
            while (hashtext.length() < 32) { 
                hashtext = "0" + hashtext; 
            } 
  
            // return the HashText 
            return hashtext; 
        } 
  
        // For specifying wrong message digest algorithms 
        catch (NoSuchAlgorithmException e) { 
            throw new RuntimeException(e); 
        } 
    } 
    
    public String getUid() {
        return this.uid;
    }
    
    public String getPwd() {
        return this.pwd;
    }
    
    public String getName() {
        return this.name;
    }
    
    public int getCoins() {
        return this.coins;
    }
    
    public String getRegdate() {
        return this.regdate;
    }
    
    public String getAbout() {
        return this.about;
    }
    
    public String getInterests() {
        return this.interests;
    }
    
    public String getPicid() {
        return this.pic_id;
    }
    
    public void setUid(String uid) {
        this.uid = uid;
    }
    
    public void setPwd(String pwd) {
        this.pwd = pwd;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public void setCoins(int coins) {
        this.coins = coins;
    }
    
    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }
    
    public void setAbout(String about) {
        this.about = about;
    }
    
    public void setInterests(String interests) {
        this.interests = interests;
    }
    
    public void setPicid(String picid) {
        this.pic_id = picid;
    }
    
    public boolean hasOrder(String pid) {
        return Order.orderExists(pid,this.uid) > 0;
    }
    
    /**
     * add user to database with credentials
     * @return status code 0 for success, <0 for error
     */
    public static User register(String username, String password) {
        conn = DBConnector.getConn();
        if (addUser(username,hash256(password),new Date().toLocaleString().substring(0,12)) == 0)
            return getUser(username);
        else
            return null;
    }
    
    public static boolean login(String username, String password) {
        conn = DBConnector.getConn();
        String stmt = "select * from apollo7_conceptize.user where uid=? and pwd=?;";
        ResultSet rs;
        
        try {
            PreparedStatement ps = conn.prepareStatement(stmt);
            ps.setString(1,username);
            ps.setString(2,hash256(password));
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            return false;
        }
    }
    
    public static void main(String argv[]) {
        conn = DBConnector.getConn();
        System.out.println(User.getUser("Test").getOrders());
    }
    
    public void save() {
        conn = DBConnector.getConn();
        String stmt = "update apollo7_conceptize.user set name = ?, coins = ?, about = ?, interests = ?, pic = ? where uid = ?;";
        
        try {
            PreparedStatement ps = conn.prepareStatement(stmt);
            ps.setString(1, this.name);
            ps.setInt(2,this.coins);
            ps.setString(3, this.about);
            ps.setString(4,this.interests);
            ps.setString(5,this.pic_id);
            ps.setString(6,this.uid);
            ps.executeUpdate();
        } catch (Exception e) {
        
        }
    }
    
    public static User getUser(String uid) {
        conn = DBConnector.getConn();
        String statement = "select * from apollo7_conceptize.user where uid=?;";
        ResultSet rs;
        
        try {
            PreparedStatement selUser = conn.prepareStatement(statement);
            selUser.setString(1, uid);
            rs = selUser.executeQuery();

            if (rs.next()) {
                User newUser = new User();

                newUser.setUid(rs.getString("uid"));
                newUser.setName(rs.getString("name"));
                newUser.setPwd(rs.getString("pwd"));
                newUser.setCoins(rs.getInt("coins"));
                newUser.setRegdate(rs.getString("regdate"));
                newUser.setAbout(rs.getString("about"));
                newUser.setInterests(rs.getString("interests"));
                newUser.setPicid(rs.getString("pic"));   
                
                return newUser;
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public boolean hasProduct(String pid) {
        try {
            Integer ipid = Integer.parseInt(pid);
            return hasProduct(ipid);
        } catch (Exception e) {
            return false;
        }
    }
    
    public boolean hasProduct(int pid) {
        String stmt = "select * from product where pid = ? and uid = ?;";
        ResultSet rs;
        
        try {
            PreparedStatement ps = conn.prepareStatement(stmt);
            ps.setInt(1,pid);
            ps.setString(2, this.uid);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
            
        } catch (Exception e) {
            return false;
        }
    }
    
    public ArrayList<ArrayList<Product>> getProducts() {
        conn = DBConnector.getConn();
        String stmt = "select pid from apollo7_conceptize.product where uid = ?;";
        ArrayList<ArrayList<Product>> out = new ArrayList<>();
        ArrayList<Product> tmp = new ArrayList<>();
        ResultSet rs;

        try {
            PreparedStatement ps = conn.prepareStatement(stmt);
            ps.setString(1, this.uid);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                tmp.add(Product.getProduct(rs.getInt("pid")));
            }
            
            for (int i = 0; i < tmp.size(); i++) {
                if (i % 2 == 0) {
                    try {
                        ArrayList<Product> tmp2 = new ArrayList<>();
                        tmp2.add(tmp.get(i));
                        tmp2.add(tmp.get(i+1));
                        out.add(tmp2);
                    } catch (Exception e) {
                        ArrayList<Product> tmp2 = new ArrayList<>();
                        tmp2.add(tmp.get(i));
                        tmp2.add(null);
                        out.add(tmp2);                  
                    }
                }
            }
            
            return out;
            
        } catch (Exception e) {
            return null;
        }
    }
    
     public ArrayList<Order> getOrders() {
         conn = DBConnector.getConn();
        String stmt = "select oid from apollo7_conceptize.order where uid = ?;";
        ArrayList<Order> out = new ArrayList<>();
        ResultSet rs;

        try {
            PreparedStatement ps = conn.prepareStatement(stmt);
            ps.setString(1, this.uid);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                out.add(Order.getOrder(rs.getInt("oid")));
            }   
            
            return out;
            
        } catch (Exception e) {
            return null;
        }
    }
     
     public ArrayList<Order> getBuyers() {
         conn = DBConnector.getConn();
        String stmt = "select `order`.uid, `order`.oid from product inner join `order` on `order`.pid = product.pid where product.uid=?;";
        ArrayList<Order> out = new ArrayList<>();
        ResultSet rs;

        try {
            PreparedStatement ps = conn.prepareStatement(stmt);
            ps.setString(1, this.uid);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                out.add(Order.getOrder(rs.getInt("oid")));
            }   
            
            return out;
            
        } catch (Exception e) {
            return null;
        }         
     }
    
    private static int addUser(String uid, String pwd, String regdate) {
        conn = DBConnector.getConn();
        String stmt = "insert into `user` (uid,pwd,regdate,pic) values (?,?,?,?);";
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            // if user exists, return error
            ps = conn.prepareStatement("select * from `user` where uid=?;");
            ps.setString(1,uid);
            rs = ps.executeQuery();
            
            if (rs.next())
                return -1; // user exists error
            
            ps = conn.prepareStatement(stmt);
            ps.setString(1,uid);
            ps.setString(2,pwd);
            ps.setString(3,regdate);
            ps.setString(4, "http://s3.amazonaws.com/37assets/svn/765-default-avatar.png");
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
            return -2;  // sql exception
        }
        
        return 0;
    }
    
    @Override
    public String toString() {
        return this.uid;
    }
}
