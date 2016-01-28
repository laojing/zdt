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
	<div id="powererror" class="panel">
	    <div class="panel-heading">转矩控制实时曲线</div>
		<div class="form-group">
			<label for="sel_windField" class="sr-only">风场:</label>
			<div class="input-group">
				<div class="input-group-addon">选择机组：</div>
				<select id="turbinenum" class="form-control"> </select>
			</div>
		</div>
		<canvas id="followgood" width="100%" height="100%"></canvas>
	</div>
	</div>
	</div>
<script>

var pitchurl = "${createLink(controller='pitch',action:'getupdatedata')}";

function DrawPitchReal ( obj, realspeed, realwind, realpower, realpitch ) {
	var can = document.getElementById ( obj );
	var context = can.getContext ( '2d' );

	var width = can.width;
	var height = can.height;
	can.width = 0;
	can.height = 0;
	can.width = width;
	can.height = height;
	
	var lineColors = ['#000040', '#004000', '#2000a0',
				'#800020', '#202040', '#8020a0'];
	drawYLabel ( context, width, height, 20, 25, 70, 125, 35, 4, 5, "%.0f", 0.8, lineColors[1], 0, 50, '风速(m/s)' );
	drawYLabel ( context, width, height, 20, 25, 125, 195, 35, 4, 5, "%.0f", 0.8, lineColors[2], 0, 2000, '功率(kW)' );
	if ( $('#turbinenum').val() > 33 ) {
		drawBackground ( context, width, height, 20, 25, 265, 35, 7, 12, 0.1, '#666666' );
		drawYLabel ( context, width, height, 20, 25, 0, 70, 35, 4, 5, "%.0f", 0.8, lineColors[0], 0, 2000, '转速(rpm)' );
		drawYLabel ( context, width, height, 20, 25, 195, 265, 35, 4, 5, "%.1f", 0.8, lineColors[3], 0, 90.0, '桨距角(deg)' );
		drawXLabel ( context, width, height, 20, 25, 265, 35, 3, 3, "%.0f", 0.8, '#666666', new Date()-(3600*24*1000), new Date(), '', 1 );
		drawLine ( context, width, height, 20, 25, 265, 35, 3, lineColors[0], new Date()/1000-(3600*24), new Date()/1000, 0, 20, realspeed );
		drawLine ( context, width, height, 20, 25, 265, 35, 3, lineColors[1], new Date()/1000-(3600*24), new Date()/1000, 0, 50, realwind );
		drawLine ( context, width, height, 20, 25, 265, 35, 3, lineColors[2], new Date()/1000-(3600*24), new Date()/1000, 0, 2000, realpower );
		drawLine ( context, width, height, 20, 25, 265, 35, 3, lineColors[3], new Date()/1000-(3600*24), new Date()/1000, 0, 90, realpitch );
	} else {
		drawBackground ( context, width, height, 20, 25, 195, 35, 7, 12, 0.1, '#666666' );
		drawYLabel ( context, width, height, 20, 25, 0, 70, 35, 4, 5, "%.0f", 0.8, lineColors[0], 0, 20, '转速(rpm)' );
		drawXLabel ( context, width, height, 20, 25, 195, 35, 3, 3, "%.0f", 0.8, '#666666', new Date()-(3600*24*1000), new Date(), '', 1 );
		drawLine ( context, width, height, 20, 25, 195, 35, 3, lineColors[0], new Date()/1000-(3600*24), new Date()/1000, 0, 20, realspeed );
		drawLine ( context, width, height, 20, 25, 195, 35, 3, lineColors[1], new Date()/1000-(3600*24), new Date()/1000, 0, 50, realwind );
		drawLine ( context, width, height, 20, 25, 195, 35, 3, lineColors[2], new Date()/1000-(3600*24), new Date()/1000, 0, 2000, realpower );
	}
}
var alarm = 0;
function UpdatePitch() {
	$.getJSON(pitchurl, {turbinenum:$('#turbinenum').val()}, function(data) {
		var realspeed = new Array();
		var realwind = new Array();
		var realpower = new Array();
		var realpitch = new Array();
		if ( alarm == 0 && data.real.length == 0 ) {
			alarm = 1;
			alert ( '数据库更新错误！所有数值只是页面展示作用！' );
		}
		if ( data.real.length == 0 ) {
			var start = new Date()/1000-(3600*24);
			for ( var i=0; i<144; i++ ) {
			realpower[i] = {x:start+i*600,y:1000+(Math.sin(i)*200)};
			realwind[i] = {x:start+i*600,y:10+(Math.sin(i)*5)};
			realspeed[i] = {x:start+i*600,y:1800+(Math.sin(i)*10)};
			realpitch[i] = {x:start+i*600,y:80+(Math.sin(i)*10)};
			}
		}
		for ( var i=0; i<data.real.length; i++ ) {
			realspeed[i] = {x:data.real[i].savetime,y:data.real[i].speed};
			realwind[i] = {x:data.real[i].savetime,y:data.real[i].wind};
			realpower[i] = {x:data.real[i].savetime,y:data.real[i].power};
			realpitch[i] = {x:data.real[i].savetime,y:data.real[i].pitch1};
		}
		DrawPitchReal ( "followgood", realspeed, realwind, realpower, realpitch );
	});
	window.setTimeout ( UpdatePitch, UPDATESPAN );
}


function resizeHome() {
	var height = $(window).height();		
	var width = $(window).width();		

	$('#powererror').width( width - 40 );
	$('#powererror').height( height-100 );

	var cansector = document.getElementById ('followgood');
	cansector.width = width - 40;
	cansector.height = height-190;
}
	
$(document).ready(function(){
	for ( var i=1; i<=33; i++ ) {
		$('#turbinenum').append("<option value='"+i+"'>金风"+i+"号机组</option>");
	}
	for ( var i=1; i<=33; i++ ) {
		if ( (i+33 != 59) && (i+33 != 60) )
		$('#turbinenum').append("<option value='"+(i+33)+"'>东汽"+i+"号机组</option>");
	}
	resizeHome();
	UpdatePitch();
});

$(window).resize(function(){
	resizeHome();
});

</script>
	</body>
</html>
