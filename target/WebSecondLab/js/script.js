$(document).ready(function () {

    $("#check_form").on('submit', function (e) {
        $('#error').text("");
        e.preventDefault();
        const sel = document.getElementById("option_x");
        const X = sel.options[sel.selectedIndex].value;
        if(!validationData($('input[name="R"]:checked').val(), $('input[name="Y"]').val().replace(",", "."), X)) {
            $('#error').text("Некорректные данные");
            return;
        }
        $.ajax({
            type: "GET",
            url: "index",
            data: {
                'R': $('input[name="R"]:checked').val(),
                'X': X,
                'Y': $('input[name="Y"]').val().replace(",", ".")
            },
            success: createTableRow,
            dataType: "json"
        })
    });

    $("input[type=checkbox]").click(function(){
        $("input[type=checkbox]").not(this).prop("checked", false);
    });

    function validationData(r, y, x) {
        return isValidX(x) && isValidY(y) && isValidR(r);
    }

    $('#chart').click(function (e){
        $('#error').text("");
        const R = $('input[name="R"]:checked').val()
        if (R === undefined) {
            $('#error').text("Проверьте, что R выбран");
            return;
        }
        const rect = this.getBoundingClientRect();
        const x = (e.clientX - rect.left) - $('#chart').width() / 2;
        const y = $('#chart').height() / 2 - (e.clientY - rect.top);
        const X = (R * x / ($('#chart').width() * 0.4)).toPrecision(6);
        const Y = (R * y / ($('#chart').height() * 0.4)).toPrecision(6);

        $.ajax({
            type: "GET",
            url: "index",
            data: {
                'R': R,
                'X': X,
                'Y': Y
            },
            success: createTableRow,
            dataType: "json"
        })
    })

    function isValidX(x){
        if (x === null || x === "" || x === "service") {
            return false;
        }
        return true;
    }

    function isValidY(y){
        if (y === "" || y === null) {
            return false;
        }
        if (y < -3 || y > 5) {
            return false;
        }
        return true;
    }

    function isValidR(r){
        if (r === "" | r === null) {
            return false;
        }
        return true;
    }

    function makeSVG(tag, attrs) {
        var el= document.createElementNS('http://www.w3.org/2000/svg', tag);
        for (var k in attrs)
            el.setAttribute(k, attrs[k]);
        return el;
    }


    function appendPoint(data) {
        var circle= makeSVG('circle', {cx: data.x * $('#chart').attr('width') * 0.4/ data.r + $('#chart').attr('width') / 2, cy: -data.y * $('#chart').attr('height')* 0.4/data.r + $('#chart').attr('height') / 2, r:3, fill: data.inArea ? "green" : "red"});
        $('#chart').append(circle);
    }

    function createTableRow(json_object){
        appendPoint(json_object);
        $(".history_table_body").prepend(`
			<tr>
				<td>${new Number(json_object.x).toPrecision(4)}</td>
				<td>${new Number(json_object.y).toPrecision(4)}</td>
				<td>${new Number(json_object.r).toPrecision(4)}</td>
				<td>${json_object.inArea ? "Да" : "Нет" }</td>
	            <td>${json_object.date}</td>
	            <td>${json_object.workTime + " ms"}</td>
			</tr>
        `);
    }
    $("#button_reset").on('click', function(e){
        $('.history_table_body').html("");
        $.ajax({
            type: "POST",
            url: "index",
            dataType: "json"
        })
    });
});

