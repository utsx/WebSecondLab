package ru.utsx;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ru.utsx.classes.Point;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

public class AreaCheckServlet extends HttpServlet {



    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher pageDispatcher = req.getRequestDispatcher("/index.jsp");

        HttpSession httpSession = req.getSession();
        System.out.println(httpSession.getId());
        ArrayList<Point> points = null;
        if (httpSession.getAttribute("points") != null) {
            points = (ArrayList<Point>) httpSession.getAttribute("points");
        }
        else{
            points = new ArrayList<>();
        }

        Point point = null;
        try {
            point = new Point(req.getParameter("X"), req.getParameter("Y"), req.getParameter("R"));
        }
        catch (NumberFormatException e) {
            pageDispatcher.forward(req, resp);
        }
        points.add(point);
        httpSession.setAttribute("points", points);

        try(PrintWriter pw = resp.getWriter()){
            assert point != null;
            pw.println(point.toString());
        }
    }
}

