package ru.utsx;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ControllerServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher checkDispatcher = req.getServletContext().getRequestDispatcher("/check");
        RequestDispatcher indexDispatcher = req.getServletContext().getRequestDispatcher("/index.jsp");
        String x = req.getParameter("X");
        String y = req.getParameter("Y");
        String r = req.getParameter("R");
        if (x != null && y != null && r != null){
            checkDispatcher.forward(req, resp);
        }
        else{
            indexDispatcher.forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher indexDispatcher = req.getRequestDispatcher("/index.jsp");
        indexDispatcher.forward(req, resp);
    }

}
