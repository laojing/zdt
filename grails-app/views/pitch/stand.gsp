<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>中电投风电场优化系统</title>
	</head>
	<body>
	<asset:javascript src="curve.js"/>

	<div class="mainpage">
	<div class="container">

	<div class="input-group">
	    <span class="input-group-addon glyphicon glyphicon-gift"></span>
		<select class="form-control" id="classes" onchange="ChangeClass();">
		  <option selected value="2">金风机组</option>
		  <option value="3">东汽机组</option>
		</select>
	    <span class="input-group-addon glyphicon glyphicon-gift"></span>
  	</div>
	<div class="seperator"></div>

	<div class="row" style="height:100%;">
	<div class="col-lg-6 col-md-6" id="canselfparent">
	<table class="table">
	<tr>
	<th>转速(rpm)</th><th>转矩(kNm)</th>
	</tr>

	<tr>
	<td><input id="speed1" class="form-control" type="text" value="0.0"></td>
	<td><input id="power1" class="form-control" type="text" value="0.0"></td>
	</tr>

	<tr>
	<td><input id="speed2" class="form-control" type="text" value="0.0"></td>
	<td><input id="power2" class="form-control" type="text" value="0.0"></td>
	</tr>


	<tr>
	<td><input id="speed3" class="form-control" type="text" value="0.0"></td>
	<td><input id="power3" class="form-control" type="text" value="0.0"></td>
	</tr>


	<tr>
	<td><input id="speed4" class="form-control" type="text" value="0.0"></td>
	<td><input id="power4" class="form-control" type="text" value="0.0"></td>
	</tr>


	<tr>
	<td><input id="speed5" class="form-control" type="text" value="0.0"></td>
	<td><input id="power5" class="form-control" type="text" value="0.0"></td>
	</tr>


	<tr>
	<td><input id="speed6" class="form-control" type="text" value="0.0"></td>
	<td><input id="power6" class="form-control" type="text" value="0.0"></td>
	</tr>


	<tr>
	<td><input id="speed7" class="form-control" type="text" value="0.0"></td>
	<td><input id="power7" class="form-control" type="text" value="0.0"></td>
	</tr>


	<tr>
	<td><input id="speed8" class="form-control" type="text" value="0.0"></td>
	<td><input id="power8" class="form-control" type="text" value="0.0"></td>
	</tr>


	<tr>
	<td><input id="speed9" class="form-control" type="text" value="0.0"></td>
	<td><input id="power9" class="form-control" type="text" value="0.0"></td>
	</tr>


	<tr>
	<td><input id="speed10" class="form-control" type="text" value="0.0"></td>
	<td><input id="power10" class="form-control" type="text" value="0.0"></td>
	</tr>


	<tr>
	<td><input id="speed11" class="form-control" type="text" value="0.0"></td>
	<td><input id="power11" class="form-control" type="text" value="0.0"></td>
	</tr>

	</table>
	</div>
	<div class="col-lg-6 col-md-6" style="height:100%">
		<div class="content" style="height:100%">
			<canvas id="canself"></canvas>
		</div>
	</div>
	</div>
	<button type="button" class="btn btn-primary btn-lg btn-block" onclick=SaveData()>保存</button>
	</div>


<script>

var ttt;
var url = "${createLink(controller='pitch',action:'getdefault')}";
var seturl = "${createLink(controller='pitch',action:'setdefault')}";
function SetDefault ( turbtype ) {
	$.getJSON(url, {turbtype:turbtype}, function(data) {
		var curgain = new Array();
		for ( var i=0; i<data.defaults.length; i++ ) {
			$('#speed'+(i+1)).val(data.defaults[i].wind);
			$('#power'+(i+1)).val(data.defaults[i].power);
			curgain[i] = {x:data.defaults[i].wind, y:data.defaults[i].power};
		}
		DrawDefault( turbtype, $('#canselfparent'), "canself", curgain );
	});
}

function DrawDefault ( turbtype, parentdiv, canid, curgain ) {
	var can = document.getElementById ( canid );
	var context = can.getContext ( '2d' );

	can.width = 0; 
	can.height = 0;
	can.width = parentdiv.width();
	can.height = parentdiv.height();

	var lineColors = ['#000040', '#004000'];
	if( turbtype < 3 ) {
		drawBackground ( context, can.width, can.height, 30, 40, 90, 35, 10, 20, 0.1, '#666666' );
		drawYLabel ( context, can.width, can.height, 30, 40, 0, 90, 35, 4, 5, "%.0f", 0.8, lineColors[0], 0, 1000, '转矩(kNm)' );
		drawXLabel ( context, can.width, can.height, 30, 40, 90, 35, 5, 4, "%.0f", 0.8, '#666666', 0, 20, '转速(rpm)', 0 );
		drawLine ( context, can.width, can.height, 30, 40, 90, 35, 2, lineColors[0], 0, 20, 0, 1000, curgain );

	} else {
		drawBackground ( context, can.width, can.height, 30, 40, 70, 35, 10, 20, 0.1, '#666666' );
		drawYLabel ( context, can.width, can.height, 30, 40, 0, 70, 35, 4, 5, "%.0f", 0.8, lineColors[0], -1000, 10000, '转矩(Nm)' );
		drawXLabel ( context, can.width, can.height, 30, 40, 70, 35, 5, 4, "%.0f", 0.8, '#666666', 0, 2000, '转速(rpm)', 0 );
		drawLine ( context, can.width, can.height, 30, 40, 70, 35, 2, lineColors[0], 0, 2000, -1000, 10000, curgain );
	}
}


function ChangeClass() {
	SetDefault ( $('#classes').val() );
}

function SaveData() {
	var sets1 = '';
	var sets2 = '';
	for ( var i=0; i<10; i++ ) {
		sets1 += $('#speed'+(i+1)).val() + "==";
		sets2 += $('#power'+(i+1)).val() + "==";
	}
	sets1 += $('#speed11').val();
	sets2 += $('#power11').val();
	$.getJSON(seturl, {turbtype:$('#classes').val(),speeds:sets1,torques:sets2}, function(data) {
		for ( var i=0; i<data.defaults.length; i++ ) {
			$('#speed'+(i+1)).val(data.defaults[i].wind);
			$('#power'+(i+1)).val(data.defaults[i].power);
		}
	});
}

$(document).ready(function(){
	SetDefault( 2 );
});

</script>

	</body>
</html>


