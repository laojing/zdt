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
	    <div class="panel-heading">转矩控制拟合曲线 </div>

		<div class="form-group">
			<label for="sel_windField" class="sr-only">风场:</label>
			<div class="input-group">
				<div class="input-group-addon">选择机组：</div>
				<select id="turbinenum" onchange="ChangeTurb(this)" class="form-control"> </select>
			</div>
		</div>
		<canvas id="followgood" width="100%" height="100%"></canvas>
	</div>
	</div>
	</div>
<script>

var pitchurl = "${createLink(controller='pitch',action:'getfittingdata')}";
function UpdatePitchFitting () {
	var turbnum = $('#turbinenum').val();
	$.getJSON(pitchurl, {turbinenum:turbnum}, function(data) {
		var turbgains = new Array();
		var index = 0;
		for ( var i=0; i<data.gains.length; i++ ) {
			var x = data.gains[i].speed;
			var y = 0;
			if ( x > 4 ) {
				y = data.gains[i].power*9550/x;
				if ( (turbnum<=33 && y > 200000 && y<400000 && x>11.5 && x<17)
						|| (turbnum>33 && y > 1500 && y<3500 && x>1100 && x<1750) ) { 
					turbgains[index++] = {x:x,y:y};
				}
			}
		}
		var timespan = 200;
		var start = 200000;
		var span = 200000/timespan;
		if ( turbnum >33 ) {
			start = 1500;
			span = 2000/timespan;
		}
		var curgain = new Array();
		for ( var i=0; i<timespan; i++ ) {
			var y = start+i*span;
			var x = 0;
			if ( data.curgain > 0 ) x = Math.sqrt(y/data.curgain);
			curgain[i] = {x:x, y:y};
		}
		DrawPitchFitting ( "followgood", turbgains, curgain );
	});
}

function DrawPitchFitting ( obj, turbgains, curgain ) {
	var can = document.getElementById ( obj );
	var context = can.getContext ( '2d' );

	var width = can.width;
	var height = can.height;
	can.width = 0;
	can.height = 0;
	can.width = width;
	can.height = height;
	
	var lineColors = ['#000040', '#004000'];
	if ( $('#turbinenum').val() > 33 ) {
		drawBackground ( context, width, height, 30, 40, 70, 35, 10, 20, 0.1, '#666666' );
		drawYLabel ( context, width, height, 30, 40, 0, 70, 35, 4, 5, "%.0f", 0.8, lineColors[0], 0, 3500, '转矩(Nm)' );
		drawXLabel ( context, width, height, 30, 40, 70, 35, 5, 4, "%.0f", 0.8, '#666666', 0, 2000, '转速(rpm)', 0 );
		if ( turbgains.length > 0 ) {
		drawPoints ( context, width, height, 30, 40, 70, 35, 2, lineColors[0], 0, 2000, 0, 3500, turbgains );
		drawLine ( context, width, height, 30, 40, 70, 35, 2, lineColors[0], 0, 2000, 0, 3500, curgain );
		} else {
		}
	} else {
		drawBackground ( context, width, height, 30, 40, 90, 35, 10, 20, 0.1, '#666666' );
		drawYLabel ( context, width, height, 30, 40, 0, 90, 35, 4, 5, "%.0f", 0.8, lineColors[0], 0, 500000, '转矩(Nm)' );
		drawXLabel ( context, width, height, 30, 40, 90, 35, 5, 4, "%.0f", 0.8, '#666666', 0, 20, '转速(rpm)', 0 );
		if ( turbgains.length > 0 ) {
		drawPoints ( context, width, height, 30, 40, 90, 35, 2, lineColors[0], 0, 20, 0, 500000, turbgains );
		drawLine ( context, width, height, 30, 40, 90, 35, 2, lineColors[0], 0, 20, 0, 500000, curgain );
		} else {
		}
	}
}

function ChangeTurb ( obj ) {
	UpdatePitchFitting();
}

function resizeHome() {
	var height = $(window).height();		
	var width = $(window).width();		

	$('#powererror').width( width - 40 );
	$('#powererror').height( height-100 );

	var cansector = document.getElementById ('followgood');
	cansector.width = width - 40;
	cansector.height = height-180;
	
	UpdatePitchFitting();
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
});

$(window).resize(function(){
	resizeHome();
});

</script>
	</body>
</html>
