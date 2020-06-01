/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package search;

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
public class SearchServlet extends HttpServlet {

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
            out.println("<title>Servlet SearchServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchServlet at " + request.getContextPath() + "</h1>");
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
        if (action.equals("searchxml")) {
            try (PrintWriter out = response.getWriter()) {
                String text = request.getParameter("text");
                int cat = Integer.parseInt(request.getParameter("cat"));
                response.setContentType("application/xml");
                response.setCharacterEncoding("UTF-8");

                out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                out.println(Product.search(text, cat));

            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }

        } else if (action.equals("search")) {
            HttpSession ses = request.getSession(true);
            String cat = request.getParameter("cat");
            String text = request.getParameter("text");
            
            if (ses.getAttribute("SEARCH_CATEGORY") == null) {
                ses.setAttribute("SEARCH_CATEGORY", "7");
            }
            
            try {
                // if cat is not valid, dont change category in session
                int tmp = Integer.parseInt(cat);
                
                if (tmp < 0 || tmp > 7 || request.getParameter("change").equals("0"))
                    throw new Exception();
                else {
                    ses.setAttribute("SEARCH_CATEGORY", cat);
                }
            } catch (Exception e) {
                cat = "7";
            } finally {
                request.setAttribute("cat", cat);  
            }

            url = "/search.jsp";

        }

        if (!action.equals("productxml")
                && !action.equals("searchxml")
                && !action.equals("category")) {
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
