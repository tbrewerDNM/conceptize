/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package profile;

import user.*;
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
public class ProfileServlet extends HttpServlet {

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
                    
                    // if user login was successful
                if (action.equals("editProfile")) { //edit profile changes
                    HttpSession ses = request.getSession(true);
                    //ses.setAttribute("LOGIN_USER", request.getParameter("username"));
                    User user = User.getUser(request.getParameter("username"));
                    if (request.getParameter("pfp").toString() != "") {
                        user.setPicid(request.getParameter("pfp"));  
                    }
                    
                    if (request.getParameter("user-name").toString() != "") {
                        user.setName(request.getParameter("user-name"));
                    } else {
                        user.setName("");
                    }
                    
                    if (request.getParameter("user-about").toString() != "") {
                        user.setAbout(request.getParameter("user-about"));
                    } else {
                        user.setAbout("");
                    }
                    
                    if (request.getParameter("user-interests").toString() != "") {
                        user.setInterests(request.getParameter("user-interests"));
                    } else {
                        user.setInterests("");
                    }
                    
                    user.save(); 
                    
                    url = "/profile.jsp";
                } else if (action.equals("profile")) {
                    String uid = request.getParameter("uid");
                    
                    if (uid == null || User.getUser(uid) == null)
                        url = "/error.jsp";
                    else
                        url = "/profile.jsp";
                } else if (action.equals("gotoEdit")) {
                    url = "/edit-profile.jsp";
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
