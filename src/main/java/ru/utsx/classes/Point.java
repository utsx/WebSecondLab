package ru.utsx.classes;

import java.text.SimpleDateFormat;

public class Point {

    private final double x;
    private final double y;
    private final double r;

    private final String date;
    private final Boolean inArea;

    public Point(String x, String y, String r) {
        this.x = Double.parseDouble(x);
        this.y = Double.parseDouble(y);
        this.r = Double.parseDouble(r);
        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss dd.MM.yyyy");
        this.date = format.format(new java.sql.Timestamp(System.currentTimeMillis()));
        inArea = checkArea();
    }



    private boolean checkArea() {
        return checkAreaInTheFirstCoordinatePlane() || checkAreaInTheSecondCoordinatePlane()
                || checkAreaInTheThirdCoordinatePlane() || checkAreaInTheFourthCoordinatePlane();
    }

    private boolean checkAreaInTheFirstCoordinatePlane() {
        if(x >= 0 && x <= r) {
            return y >= 0 && Math.pow(x, 2) + Math.pow(y, 2) <= Math.pow(r, 2);
        }
        return false;
    }

    private boolean checkAreaInTheSecondCoordinatePlane() {
        return false;
    }

    private boolean checkAreaInTheThirdCoordinatePlane() {
        if(x <= 0 && x >= -r / 2 && y <= 0 && y >= -r) {
            return y >= - 2 * x + r;
        }
        return false;
    }

    private boolean checkAreaInTheFourthCoordinatePlane() {
        return x >= 0 && x <= r && y <= 0 && y >= -r;
    }

    public Boolean getInArea() {
        return inArea;
    }

    @Override
    public String toString() {
        return "{" +
                "\"x\": " + x +
                ",\n\"y\": " + y +
                ", \n\"r\": " + r +
                ", \n\"date\":" + "\"" +date.toString() + "\"" +
                ", \n\"inArea\":" + ""+inArea+"" +
                '}';
    }


    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getR() {
        return r;
    }

    public String getDate() {
        return date;
    }
}
