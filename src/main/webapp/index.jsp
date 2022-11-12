<%@ page import="java.util.*" %>
<%@ page import="ru.utsx.classes.Point" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/style.css">
    <title>WebSecondLab</title>
</head>
<header>
    <h3 class="title">Александров Дмитрий Александрович Вариант</h3>
    <h3 class="title">Агнаев Александр Юрьевич</h3>
    <h3 class="title">Группа 32212</h3>
    <h3 class="title">Вариант 13928</h3>
</header>
<body>
<table class="main_table">
    <tr>
        <th class="input_fields">Поля для ввода</th>
        <th class="history">История</th>
        <th class="chart">График</th>
    </tr>
    <tr>
        <td>
            <form id="check_form" method="GET">
                <div class="select_x">
                    <legend><b>Значение координаты X:</b></legend>
                    <select name="option_x" id="option_x">
                        <option value="service">Выберите x от -2 до 2</option>
                        <option value="-2">-2</option>
                        <option value="-1.5">-1.5</option>
                        <option value="-1">-1</option>
                        <option value="-0.5">0.5</option>
                        <option value="0">0</option>
                        <option value="0.5">0.5</option>
                        <option value="1">1</option>
                        <option value="1.5">1.5</option>
                        <option value="2">2</option>
                    </select>
                </div>
                <div class="text_y">
                    <legend><b>Значения координаты Y</b></legend>
                    <input type="text" name="Y" value="" , placeholder="Введите любое y от -3 до 5">
                </div>
                <div class="checkbox_r">
                    <legend><b>Значения координаты R</b><br>Выберите значение R из предложенных</legend>
                    <input type="checkbox" name="R" value="1">1<br>
                    <input type="checkbox" name="R" value="2">2<br>
                    <input type="checkbox" name="R" value="3">3<br>
                    <input type="checkbox" name="R" value="4">4<br>
                    <input type="checkbox" name="R" value="5">5<br>
                </div>
                <div>
                    <input type="submit" value="Отправить">
                    <input id="button_reset" type="button" value="Очистить">
                </div>
                <div id="error" class="my_error">

                </div>
            </form>
        </td>
        <td>
            <table class="history_table">
                <%
                    List<Point> points = (List<Point>) request.getSession().getAttribute("points");
                %>
                <thead>
                <tr>
                    <th>Значение X</th>
                    <th>Значение Y</th>
                    <th>Значение R</th>
                    <th>Факт попадания</th>
                    <th>Время запроса</th>
                    <th>Время исполения</th>
                </tr>
                </thead>
                <tbody class="history_table_body">
                <% if (points != null) {
                    for (Point point : points) {%>
                <tr>
                    <td><%= (double) Math.round(point.getX() * 1000) / 1000 %>
                    </td>
                    <td><%= (double) Math.round(point.getY() * 1000) / 1000 %>
                    </td>
                    <td><%= (double) Math.round(point.getR() * 1000) / 1000 %>
                    </td>
                    <td><%= point.getInArea() ? "Да" : "Нет" %>
                    </td>
                    <td><%= point.getDate() %>
                    </td>
                    <td><%= point.getWorkTime() + " ms"%>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </td>
        <td class="my_svg">
            <div>
                <svg class="chart" viewBox="-100 -100 200 200" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <marker id='arrow-head' orient="auto" markerWidth='2' markerHeight='4' refX='0.1' refY='2'>
                            <path d='M0,0 V4 L2,2 Z' fill="black"></path>
                        </marker>
                    </defs>

                    <!--Фигуры-->
                    <polygon points="0 0 0 80 -40 0" fill="rgb(0, 140, 203)"></polygon>
                    <rect x="0" y="0" width="80" height="80" fill="rgb(0, 140, 203)"></rect>
                    <path fill="rgb(0, 140, 203)" d="M 80 0 a 80 80 0 0 0 -80 -80 L 0 0 Z"></path>
                    <path d="M -95 0, h 190" stroke="black" stroke-width="1" marker-end="url(#arrow-head)"></path>
                    <path d="M 0 95, v -190" stroke="black" stroke-width="1" marker-end="url(#arrow-head)"></path>

                    <!--Точки-->
                    <circle cx="0" cy="0" r="1.5" fill="black"></circle>
                    <circle cx="0" cy="40" r="1.5" fill="black"></circle>
                    <circle cx="0" cy="-40" r="1.5" fill="black"></circle>
                    <circle cx="40" cy="0" r="1.5" fill="black"></circle>
                    <circle cx="-40" cy="0" r="1.5" fill="black"></circle>
                    <circle cx="80" cy="0" r="1.5" fill="black"></circle>
                    <circle cx="-80" cy="0" r="1.5" fill="black"></circle>
                    <circle cx="0" cy="80" r="1.5" fill="black"></circle>
                    <circle cx="0" cy="-80" r="1.5" fill="black"></circle>

                    <!--Обозначения-->
                    <text x="90" y="-3" class="inscription">x</text>
                    <text x="3" y="-90" class="inscription">y</text>
                    <text x="40" y="-3" class="inscription">R/2</text>
                    <text x="-45" y="-3" class="inscription">-R/2</text>
                    <text x="3" y="40" class="inscription">-R/2</text>
                    <text x="3" y="-40" class="inscription">R/2</text>
                    <text x="80" y="-3" class="inscription">R</text>
                    <text x="-85" y="-3" class="inscription">-R</text>
                    <text x="3" y="80" class="inscription">-R</text>
                    <text x="3" y="-75" class="inscription">R</text>
                </svg>
            </div>
        </td>
    </tr>
</table>
</body>
<footer></footer>
<script src="js/jquery-3.5.1.min.js"></script>
<script src="js/script.js"></script>
</html>