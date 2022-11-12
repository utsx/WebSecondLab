$(document).ready(function () {

    $("#check_form").on('submit', function (e) {
        e.preventDefault();
        const sel = document.getElementById("option_x");
        const X = sel.options[sel.selectedIndex].value;
        if(!validationData($('input[name="R"]:checked').val(), $('input[name="Y"]').val(), X)) {
            alert("Validation failed");
            return;
        }
        $.ajax({
            type: "GET",
            url: "index",
            data: {
                'R': $('input[name="R"]:checked').val(),
                'X': X,
                'Y': $('input[name="Y"]').val()
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

    function createTableRow(json_object){
        document.querySelector(".history_table_body").innerHTML += `
			<tr>
				<td>${new Number(json_object.x).toPrecision(2)}</td>
				<td>${new Number(json_object.y).toPrecision(2)}</td>
				<td>${new Number(json_object.r).toPrecision(2)}</td>
				<td>${json_object.inArea ? "Да" : "Нет" }</td>
	            <td>${json_object.date}</td>
			</tr>
			`;
    }
});

//  <td>${(new Number(json_object.time * 1000)).toPrecision(3) + " ms"}</td>