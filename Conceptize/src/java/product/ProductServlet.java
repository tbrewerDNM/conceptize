/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

import beans.Order;
import beans.Product;
import beans.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author mattadik123
 */
public class ProductServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        response.addHeader("Access-Control-Allow-Origin", "*");

        String url = "/index.jsp";
        if (action.equals("productxml")) {
            try (PrintWriter out = response.getWriter()) {
                int pid = Integer.parseInt(request.getParameter("pid"));
                Product prod = Product.getProduct(pid);
                response.setContentType("application/xml");
                response.setCharacterEncoding("UTF-8");

                out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");

                if (prod != null) {
                    out.println(prod.toString());
                } else {
                    out.println("<error></error>");
                    throw new Exception();
                }

            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }

        } else if (action.equals("product")) {
            String pid = request.getParameter("pid");

            if (Product.getProduct(pid) != null) {
                url = "/product.jsp";
            }
        } else if (action.equals("product-edit")) {
            
            HttpSession ses = request.getSession(false);
            User user = (User)request.getAttribute("LOGIN_USER");
            String pid = request.getParameter("pid");

            if (Product.getProduct(pid) != null) {
                ses.setAttribute("EDIT_PRODUCT", pid);
                url = "/edit-product.jsp";
            } else {
                url = "/error.jsp";
            }
        } else if (action.equals("create-product")) {
            try {
                HttpSession ses = request.getSession(false);
                User user = (User)ses.getAttribute("LOGIN_USER");
                
                String title = request.getParameter("title");
                
                if (title == null || title.equals(""))
                    throw new Exception();
                
                String image = request.getParameter("image");
                Integer price = Integer.parseInt(request.getParameter("price"));
                
                if (price < 1)
                    throw new Exception();
                
                String desc = request.getParameter("description");
                
                Integer cat = Integer.parseInt(request.getParameter("cat"));
                boolean nego = request.getParameter("negotiable").equals("1");
                
                Product newProduct = Product.getProduct(Product.addProduct(user.getUid()).getPid());
                
                newProduct.setTitle(title);
                if (image != ""){
                    newProduct.setImg(image);
                }
                newProduct.setPrice(price);
                newProduct.setDesc(desc);
                newProduct.setCid(cat);
                newProduct.setNegotiable(nego);
                
                newProduct.save();
                
                request.removeAttribute("title");
                request.removeAttribute("image");
                request.removeAttribute("price");
                request.removeAttribute("description");
                request.removeAttribute("cat");
                request.removeAttribute("negotiable");
                
                ses.setAttribute("NEW_PRODUCT", newProduct.getPid());
                
                url = "/redirect.jsp";
                
            } catch (Exception e) {
                url = "/create-product.jsp";
            }
        } else if (action.equals("edit-product")) {
                HttpSession ses = request.getSession(false);
                User user = (User)ses.getAttribute("LOGIN_USER");
                
                String title = request.getParameter("title");
                
                try {            
                    if (title == null || title.equals(""))
                        throw new Exception();

                    String image = request.getParameter("image");
                    Integer price = Integer.parseInt(request.getParameter("price"));

                    if (price < 1)
                        throw new Exception();

                    String desc = request.getParameter("description");

                    Integer cat = Integer.parseInt(request.getParameter("cat"));
                    boolean nego = request.getParameter("negotiable").equals("1");

                    Product newProduct = Product.getProduct(request.getParameter("pid"));

                    newProduct.setTitle(title);
                    
                    if (image != ""){
                        newProduct.setImg(image);
                    }
                    
                    newProduct.setPrice(price);
                    newProduct.setDesc(desc);
                    newProduct.setCid(cat);
                    newProduct.setNegotiable(nego);

                    newProduct.save();

                    request.removeAttribute("title");
                    request.removeAttribute("image");
                    request.removeAttribute("price");
                    request.removeAttribute("description");
                    request.removeAttribute("cat");
                    request.removeAttribute("negotiable");

                    ses.setAttribute("NEW_PRODUCT", newProduct.getPid());

                    url = "/redirect.jsp";            
                } catch (Exception e) {
                    url = "/error.jsp";
                }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(url);
        dispatcher.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
