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
                <svg id="chart" width="500" height="500" viewBox="0 0 500 500" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <polygon points="250,250 250,450 150,250" fill="rgb(0, 140, 203)" />
                    <mask id="quarter" maskUnits="userSpaceOnUse" x="250" y="50" width="200" height="200">
                        <circle cx="250" cy="250" r="200" fill="#FFFFFF"/>
                    </mask>
                    <g mask="url(#quarter)">
                        <rect x="250" y="50" width="200" height="200" fill="rgb(0, 140, 203)"/>
                    </g>
                    <rect x="250" y="250" width="200" height="200" fill="rgb(0, 140, 203)"/>


                    <line x1="250" y1="0" x2="250" y2="500" stroke-width=2 stroke="black"/>

                    <text x="265" y="10"  fill="black" font-family="sans-serif" font-size="18">y</text>
                    <line x1="250" y1="0" x2="245" y2="12" stroke-width=2 stroke="black"/>
                    <line x1="255" y1="12" x2="250" y2="0" stroke-width=2 stroke="black"/>

                    <line x1="500" y1="250" x2="0" y2="250" stroke-width=2 stroke="black"/>

                    <text x="490" y="240"  fill="black" font-family="sans-serif" font-size="18">x</text>
                    <line x1="500" y1="250" x2="488" y2="245" stroke-width=2 stroke="black"/>
                    <line x1="488" y1="255" x2="500" y2="250" stroke-width=2 stroke="black"/>


                    <text x="350" y="240" class="r2p" fill="black" font-family="sans-serif" font-size="18">R/2</text>
                    <line x1="350" y1="245" x2="350" y2="255" stroke-width=2 stroke="black"/>

                    <text x="260" y="150" class="r2p" fill="black" font-family="sans-serif" font-size="18">R/2</text>
                    <line x1="245" y1="150" x2="255" y2="150" stroke-width=2 stroke="black"/>

                    <text x="150" y="240" class="r2n" fill="black" font-family="sans-serif" font-size="18">-R/2</text>
                    <line x1="150" y1="245" x2="150" y2="255" stroke-width=2 stroke="black"/>

                    <text x="260" y="350" class="r2n" fill="black" font-family="sans-serif" font-size="18">-R/2</text>
                    <line x1="255" y1="350" x2="245" y2="350" stroke-width=2 stroke="black"/>

                    <text x="450" y="240" class="rp" fill="black" font-family="sans-serif" font-size="18">R</text>
                    <line x1="450" y1="245" x2="450" y2="255" stroke-width=2 stroke="black"/>

                    <text x="260" y="55" class="rp" fill="black" font-family="sans-serif" font-size="18">R</text>
                    <line x1="245" y1="50" x2="255" y2="50" stroke-width=2 stroke="black"/>

                    <text x="50" y="240" class="rn" fill="black" font-family="sans-serif" font-size="18">-R</text>
                    <line x1="50" y1="245" x2="50" y2="255" stroke-width=2 stroke="black"/>

                    <text x="260" y="450" class="rn" fill="black" font-family="sans-serif" font-size="18">-R</text>
                    <line x1="245" y1="450" x2="255" y2="450" stroke-width=2 stroke="black"/>
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