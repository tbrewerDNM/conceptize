package beans;

import java.io.Serializable;
import java.nio.charset.Charset;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Random;

public class Product implements Serializable {
    public static Connection conn = DBConnector.getConn();
    
    private int pid;
    private String uid;
    private int price;
    private String title;
    private boolean negotiable;
    private int cid;
    private String description;
    private String img;
    
    Product() {
        this.pid = -1;
        this.uid = null;
        this.price = 0;
        this.title = randomString();
        this.negotiable = true;
        this.cid = 1;
        this.description = "";
        this.img = "https://discountseries.com/wp-content/uploads/2017/09/default.jpg";
    }
    
    public int getPid() {
        return this.pid;
    }
    
    public String getUid() {
        return this.uid;
    }
    
    public int getPrice() {
        return this.price;
    }
    
    public String getTitle() {
        return this.title;
    }
    
    public boolean isNegotiable() {
        return this.negotiable;
    }
    
    public int getCid() {
        return this.cid;
    }
    
    public String getDesc() {
        return this.description;
    }
    
    public String getShortDesc() {
        if (this.description.length() > 30)
            return this.description.substring(0,27) + "...";
        else
            return this.description;
    }
    
    public String getImg() {
        return this.img;
    }
    
    public void setPid(int pid) {
        this.pid = pid;
    }
    
    public void setUid(String uid) {
        this.uid = uid;
    }
    
    public void setPrice(int price) {
        this.price = price;
    }
    
    public void setTitle(String t) {
        this.title = t;
    }
    
    public void setNegotiable(boolean negotiable) {
        this.negotiable = negotiable;
    }
    
    public void setCid(int cid) {
        this.cid = cid;
    }
    
    public void setDesc(String desc) {
        this.description = desc;
    }
    
    public void setImg(String img) {
        this.img = img;
    }
    
    private static String randomString() {
        byte[] array = new byte[64]; // length is bounded by 64
        new Random().nextBytes(array);
        return new String(array, Charset.forName("UTF-8"));
    }
    
    public static Product addProduct(String username) {
        conn = DBConnector.getConn();
        String pidStmt = "select pid from product where title = ?;";
        String stmt = "insert into product (uid,price,title,negotiable,cid,description,img) values (?,?,?,?,?,?,?);";
        Product newProduct = new Product();
        ResultSet rs;
        
        try {
            PreparedStatement ps = conn.prepareStatement(stmt);
            
            ps.setString(1,username);
            ps.setInt(2,newProduct.price);
            ps.setString(3,newProduct.title);
            ps.setBoolean(4,newProduct.negotiable);
            ps.setInt(5,newProduct.cid);
            ps.setString(6,newProduct.description);
            ps.setString(7,newProduct.img);
            
            ps.executeUpdate();
            
            ps = conn.prepareStatement(pidStmt);
            ps.setString(1,newProduct.title);
            
            rs = ps.executeQuery();
            
            if (rs.next())
                newProduct.setPid(rs.getInt("pid"));
            
            return newProduct;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static void main(String argv[]) {        
        while (true) {
            System.out.println(getRandomProducts(3));
        }    
    }
    
    private static int getRandomNumber(int min, int max) {
            max--;
            if (min >= max) {
                    throw new IllegalArgumentException("max must be greater than min");
            }

            Random r = new Random();
            return r.nextInt(max);
    }
    
    public static ArrayList<Product> getRandomProducts(String n) {
            try {
                int nn = Integer.parseInt(n);
                return getRandomProducts(nn);
            } catch (Exception e) {
                return getRandomProducts(3);
            } 
    }
    
    public static ArrayList<Product> getRandomProducts(int n) {
        conn = DBConnector.getConn();
        String stmt = "select pid from product;";
        ArrayList<Product> tmp = new ArrayList<>();
        ArrayList<Product> out = new ArrayList<>();
        ResultSet rs;
        
        try {
            PreparedStatement ps = conn.prepareStatement(stmt);
            rs = ps.executeQuery();
            
            while (rs.next())
                tmp.add(getProduct(rs.getInt("pid")));
            
            for (int i = 0; i < n; i++) {
                int rand = getRandomNumber(0,tmp.size());
                out.add(tmp.get(rand));
            }
            
            return out;
            
        } catch (Exception e) {
            ArrayList<Product> temp = new ArrayList<>();
            temp.add(getProduct(2));
            temp.add(getProduct(3));
            temp.add(getProduct(4));
            return temp;
        }
    }
    
    public int addTag(String tag) {
        String checkStmt = "select * from tag where pid=? and text=?;";
        String addStmt   = "insert into tag (pid,text) values(?,?);";
        ResultSet rs;
        
        try {
            PreparedStatement ps = conn.prepareStatement(checkStmt);
            ps.setInt(1,this.pid);
            ps.setString(2,tag);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return -1;
            } else {
                ps = conn.prepareStatement(addStmt);
                ps.setInt(1,this.pid);
                ps.setString(2,tag);
                return ps.executeUpdate(addStmt);
            }
        } catch (Exception e) {
            return -1;
        }
    }
    
    public ArrayList<String> getTags() {
        conn = DBConnector.getConn();
        String stmt = "select text from tag where pid=?;";
        ArrayList<String> out = new ArrayList<>();
        ResultSet rs;
        
        try {
            PreparedStatement ps = conn.prepareStatement(stmt);
            ps.setInt(1, this.pid);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                out.add(rs.getString("text"));
            }
            
            return out;
        } catch (Exception e) {
            return null;
        }
    }
    
    public static Product getProduct(String pid) {
        try {
            int ipid = Integer.parseInt(pid);
            return getProduct(ipid);
        } catch (Exception e) {
            return null;
        }
    }
    
    public static Product getProduct(int pid) {
        conn = DBConnector.getConn();
        String statement = "select * from product where pid=?;";
        ResultSet rs;
        
        try {
            PreparedStatement sel = conn.prepareStatement(statement);
            sel.setInt(1, pid);
            rs = sel.executeQuery();
            
            if (rs.next()) {
                Product newProduct = new Product();

                newProduct.setPid(rs.getInt("pid"));  
                newProduct.setUid(rs.getString("uid"));
                newProduct.setPrice(rs.getInt("price"));
                newProduct.setTitle(rs.getString("title"));
                newProduct.setNegotiable(rs.getBoolean("negotiable"));
                newProduct.setCid(rs.getInt("cid"));
                newProduct.setDesc(rs.getString("description"));
                newProduct.setImg(rs.getString("img"));
                
                return newProduct;
            } else {
                return null;
            }
        } catch (Exception e) {
            return null;
        }
    }

    public static ArrayList<ArrayList<Product>> searchDoubles(String text, String cat) {
        conn = DBConnector.getConn();
        ArrayList<Product> prods = search(text,cat);
        ArrayList<ArrayList<Product>> out = new ArrayList<>();
        
        for (int i = 0; i < prods.size(); i++) {
            if (i % 2 == 0) {
                try {
                    ArrayList<Product> tmp = new ArrayList();
                    tmp.add(prods.get(i));
                    tmp.add(prods.get(i+1));
                    out.add(tmp);
                } catch (Exception e) {
                    ArrayList<Product> tmp = new ArrayList();
                    tmp.add(prods.get(i));
                    tmp.add(null);
                    out.add(tmp);
                }
            }
        }
        
        return out;
    }
    
    public static ArrayList<Product> search(String text, String cat) {
        return search(text,Integer.parseInt(cat));
    }
    
    public static ArrayList<Product> search(String text, int cat) {
        conn = DBConnector.getConn();
        ArrayList<Product> out = new ArrayList<>();
        String outstr = "<products>";
        String stmt;
        ResultSet rs;
        
        if (cat == 7)
            stmt = "select pid,title from product where title like ?;";
        else
            stmt = "select pid,title from product where title like ? and cid = ?;";
        
        try {
            PreparedStatement ps = conn.prepareStatement(stmt);
            ps.setString(1,"%"+text+"%");
            
            if (cat != 7)
                ps.setInt(2,cat);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                out.add(getProduct(rs.getInt("pid")));
            }
            
            for (Product p : out) {
                outstr += p.toString();
            }
            
            return out;
        } catch (Exception e) {
            return null;
        }
    }
    
    public int save() {
        conn = DBConnector.getConn();
        String stmt = "update product set price = ?, title = ?, negotiable = ?, cid = ?, description = ?, img = ? where pid = ? and uid = ?;";
        
        try {
            PreparedStatement ps = conn.prepareStatement(stmt);
            ps.setInt(1,this.price);
            ps.setString(2,this.title);
            ps.setBoolean(3,this.negotiable);
            ps.setInt(4,this.cid);
            ps.setString(5,this.description);
            ps.setString(6,this.img);
            ps.setInt(7,this.pid);
            ps.setString(8, this.uid);
            
            return ps.executeUpdate();
        } catch (Exception e) {
            return -1;
        }
    }
    
    public static String cat2str(String cat) {
        int cid = 7;
        
        try {
            cid = Integer.parseInt(cat);
        } catch (Exception e) {
        
        }
        
        return cat2str(cid);
    }
    
    public static String cat2str(int cat) {
        conn = DBConnector.getConn();
        String stmt = "select name from category where cid = ?;";
        ResultSet rs;
        
        if (cat < 0 || cat > 7) {
            cat = 7;
        }
        
        try {
          PreparedStatement ps = conn.prepareStatement(stmt);
          ps.setInt(1,cat);
          rs = ps.executeQuery();
          rs.next();
          
          return rs.getString("name");
          
      } catch (Exception e) {
          return "all";
      }      
    }
}
