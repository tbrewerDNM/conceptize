/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import beans.Order;
import beans.Product;
import beans.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author mattadik123
 */
public class AuthServlet extends HttpServlet {

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
            out.println("<title>Servlet AuthServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AuthServlet at " + request.getContextPath() + "</h1>");
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
                if (action.equals("login")){
                    HttpSession ses = request.getSession(true);
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String error = "Unable to log in with provided credentials.";
                    
                    // if user login was successful
                    if (User.login(username,password)) {
               
//                        ses.setAttribute("LOGIN_USER", username); // used for local testing
                        
                        User user = User.getUser(username);
                        
                        if (user != null) {
                            ses.setAttribute("LOGIN_USER", User.getUser(username));
                            ses.setAttribute("SEARCH_CATEGORY", "7");
                            url = "/index.jsp";
                        } else {
                            request.setAttribute("LOGIN_ERROR", error);
                            url = "/login.jsp";
                        }
                    } else {
                        request.setAttribute("LOGIN_ERROR", error);
                        url = "/login.jsp";
                    }
                } else if (action.equals("register")) {
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String error = "Username already taken.";
                    
                    if (User.register(username,password) != null) {
                        url = "/login.jsp";
                    } else {
                        request.setAttribute("REGISTER_ERROR", error);
                        url = "/register.jsp";
                    }
                } else if (action.equals("logout")) {
                    HttpSession ses = request.getSession(false);
                    ses.removeAttribute("LOGIN_USER");
                    
                    url = "/login.jsp";
                }

                if (!action.equals("productxml") && 
                    !action.equals("searchxml") && 
                    !action.equals("category")) {
                    RequestDispatcher dispatcher = request.getRequestDispatcher(url);
                    dispatcher.forward(request, response);                
                }
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
