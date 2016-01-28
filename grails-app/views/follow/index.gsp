<!doctype html>
<html>
    <head> <meta name="layout" content="main"/> </head>

    <body>

		<div class="mainpage">
		<div id="canfollowparent">
		<canvas id="canfollow" width="100%" height="100%"></canvas>
		</div>
		</div>
<script>

var lostatot = 0;
var lostbtot = 0;
var lostatran = 0;
var lostbtran = 0;
var losta = [0, 0, 0, 0, 0];
var lostb = [0, 0, 0, 0, 0];

var ptotal = [0, 0, 0, 0, 0];
var qtotal = [0, 0, 0, 0, 0];

var lines = [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
			[12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22],
			[23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33],
			[34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48],
			[49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 61, 62, 63, 64, 65, 66]];

var ttt;
var urlpower = "${createLink(controller='follow',action:'getupdatedata')}";
function UpdateOver() {
	$.getJSON(urlpower, function(data) {
		if ( data.effi.length == 0 ) {
			alert ( '数据库更新错误！所有数值只是页面展示作用！' );
		}
		for( var i=0; i<5; i++ ) {
			ptotal[i] = 0;
			qtotal[i] = 0;
			for( var j=0; j<lines[i].length; j++ ) {
				ptotal[i] += data.effi[lines[i][j]].power;
				qtotal[i] += data.effi[lines[i][j]].value;
			}
		}

		lostatot = 0;
		lostbtot = 0;
		for( var i=0; i<data.effi.length; i++ ) {
			losta[data.effi[i].turbnum-201] = 0;
			lostb[data.effi[i].turbnum-201] = 0;
			if( data.effi[i].turbnum > 200 && data.effi[i].turbnum <= 205 ){
				losta[data.effi[i].turbnum-201] = data.effi[i].value;
				lostatot += data.effi[i].value;
			}
			if( data.effi[i].turbnum > 300 && data.effi[i].turbnum <= 305 ){
				lostb[data.effi[i].turbnum-301] = data.effi[i].value;
				lostbtot += data.effi[i].value;
			}
			if( data.effi[i].turbnum == 200 ){
				lostatran = data.effi[i].value;
				lostatot += data.effi[i].value;
			}
			if( data.effi[i].turbnum == 300 ){
				lostbtran = data.effi[i].value;
				lostbtot += data.effi[i].value;
			}
		}

		DrawFollowHome( $('#canfollowparent'), 'canfollow' );
	});


	window.setTimeout ( UpdateOver, UPDATESPAN );
}

function resize() {
	var height = $(window).height();		
	var width = $(window).width();		

	$('#canfollowparent').width ( width );
	$('#canfollowparent').height ( height - 100 );

}

$(document).ready(function(){
	resize();
	UpdateOver();
});

$(window).resize(function(){
	resize();
});




function DrawFollowHome ( parentdiv, canid ) {
	var can = document.getElementById ( canid );
	var context = can.getContext ( '2d' );

	can.width = 0, can.height = 0;
	can.width = parentdiv.width();
	can.height = parentdiv.height();

	var spanx = can.width/12;
	var spany = (can.height)/3;

	DrawArrow ( context, spanx*8, spany/3, spanx*8, spany/8, spanx/8 );
	DrawMainSwitch ( context, spanx*8, spany/3, spanx/8 );
	DrawMainSwitch ( context, spanx*8, spany, spanx/8 );

	DrawMainTransfer ( context, spanx*8, spany*3/2, spanx/8 );

	for ( var i=1; i<12; i++ ) {
		if ( i == 4 || i == 9 ) {
			context.beginPath ();
			context.moveTo ( spanx*i, spany*2 - spanx/8 );
			context.lineTo ( spanx*i, spany*2 );
			context.closePath ();
			context.stroke ();
			DrawCollector ( context, spanx*i, spany*2, spanx/8 );
			DrawCollectLine ( context, spanx*i, spany*2+spanx*6/8, spanx/8, 0 );
		} else if ( i < 4 || i > 9 ) {
			context.beginPath ();
			context.moveTo ( spanx*i, spany*2 - spanx/8 );
			context.lineTo ( spanx*i, spany*2 );
			context.closePath ();
			context.stroke ();
			DrawCollector ( context, spanx*i, spany*2, spanx/8 );
			DrawCollectLine ( context, spanx*i, spany*2+spanx*6/8, spanx/8, 1 );
		}
	}

	DrawCollector ( context, spanx*11/2, spany*2, spanx/12 );
	DrawCollectLine ( context, spanx*11/2, spany*2+spanx*6/12, spanx/12, 2 );
	DrawCollectLine ( context, spanx*11/2-spanx/3, spany*2+spanx*14/12, spanx/12, 3 );
	DrawCollectLine ( context, spanx*11/2+spanx/3, spany*2+spanx*14/12, spanx/12, 4 );

	DrawCollector ( context, spanx*7, spany*2, spanx/12 );
	DrawCollectLine ( context, spanx*7, spany*2+spanx*6/12, spanx/12, 2 );
	DrawSwitch ( context, spanx*7, spany*2+spanx*11/12, spanx/12 );
	DrawCollectLine ( context, spanx*7, spany*2+spanx*14/12, spanx/12, 4 );

	DrawSwitch ( context, spanx*11/2-spanx/3, spany*2+spanx*11/12, spanx/12 );
	DrawSwitch ( context, spanx*11/2+spanx/3, spany*2+spanx*11/12, spanx/12 );



	context.beginPath ();

	context.moveTo ( spanx*11/2, spany*2 - spanx/8 );
	context.lineTo ( spanx*11/2, spany*2 );
	context.moveTo ( spanx*7, spany*2 - spanx/8 );
	context.lineTo ( spanx*7, spany*2 );

	context.moveTo ( spanx*11/2-spanx/3, spany*2+spanx*11/12 );
	context.lineTo ( spanx*11/2+spanx/3, spany*2+spanx*11/12 );
	context.moveTo ( spanx*4, spany*2+spanx*13/8 );
	context.lineTo ( spanx*9, spany*2+spanx*13/8 );

	context.moveTo ( spanx*8 - spanx/8, spany/3 );
	context.lineTo ( spanx*8 - spanx/8, spany/8 );
	context.moveTo ( spanx*8 + spanx/8, spany/3 );
	context.lineTo ( spanx*8 + spanx/8, spany/8 );

	context.moveTo ( spanx*8, spany/3 + spanx*7/8 );
	context.lineTo ( spanx*8, spany );

	context.moveTo ( spanx*8, spany + spanx*7/8 );
	context.lineTo ( spanx*8, spany*3/2 );

	context.moveTo ( spanx*8, spany*3/2 + spanx*7/16 );
	context.lineTo ( spanx*8, spany*2 + spanx*13/8 );

	context.closePath ();
	context.stroke ();

	context.beginPath ();
	context.moveTo ( spanx/2, spany*2-spanx/8 );
	context.lineTo ( spanx*15/2, spany*2-spanx/8 );
	context.moveTo ( spanx*17/2, spany*2-spanx/8 );
	context.lineTo ( spanx*23/2, spany*2-spanx/8 );
	context.moveTo ( spanx/2, spany );
	context.lineTo ( spanx*23/2, spany );
	context.closePath ();
	context.lineWidth = 1.5;
	context.stroke ();

	context.font = '13px YaHei Consolas Hybrid';
	var metrics = context.measureText ( "驼闫线" );
	context.fillText ( "驼闫线", spanx*8-metrics.width/2, spany/8 - 10 );
	context.fillText ( "220kV母线", spanx/2, spany - 10 );
//	context.fillText ( "220kV母线", spanx/2, spany - 10 );
	context.fillText ( "35kV一段母线", spanx/2, spany*2 - spanx/8 - 10 );
	metrics = context.measureText ( "主变压器" );
	context.fillText ( "主变压器", spanx*8-metrics.width-spanx*2/8, spany*3/2+spanx*2/8 );
	metrics = context.measureText ( "35kV二段母线" );
	context.fillText ( "35kV二段母线", spanx*23/2-metrics.width, spany*2 - spanx/8 - 10 );
	metrics = context.measureText ( "3#集电线" );
	context.textBaseline = "top";

	// rrrrrrrrrrrrrrrrrrrrrrrrrrrrr

	var totalx = [spanx, spanx*2, spanx*3, spanx*10, spanx*11];
	for( var i=0; i<5; i++ ) {
		context.fillText ( parseInt(ptotal[i])+"kW", totalx[i]+5, spany*2 + spanx*13/8 - 40 );
		context.fillText ( parseInt(qtotal[i])+"kVar", totalx[i]+5, spany*2 + spanx*13/8 - 15 );

		context.fillStyle = '#004000';
		context.fillText ( "L:"+parseInt(losta[i])+"kW", totalx[i]-15, spany*2 - spanx/8 - 40 );
		context.fillStyle = '#000040';
		context.fillText ( "L:"+parseInt(lostb[i])+"kW", totalx[i]-15, spany*2 - spanx/8 - 55 );
		context.fillStyle = '#000000';
	}
	context.fillStyle = '#004000';
	context.fillText ( "L:"+parseInt(lostatran)+"kW", spanx*8+70-spanx*2/8, spany*3/2+spanx*2/8-50 );
	context.fillStyle = '#000040';
	context.fillText ( "L:"+parseInt(lostbtran)+"kW", spanx*8+70-spanx*2/8, spany*3/2+spanx*2/8-65 );
	context.fillStyle = '#000000';

	context.fillStyle = '#004000';
	context.fillText ( "优化前总有功损耗:"+parseInt(lostatot)+"kW", spanx, spany/4 );
	context.fillStyle = '#000040';
	context.fillText ( "优化后总有功损耗:"+parseInt(lostbtot)+"kW", spanx, spany/8 );
	context.fillStyle = '#000000';

	context.fillText ( "1#集电线", spanx-metrics.width/2, spany*2 + spanx*13/8 + 10 );
	context.fillText ( "2#集电线", spanx*2-metrics.width/2, spany*2 + spanx*13/8 + 10 );
	context.fillText ( "3#集电线", spanx*3-metrics.width/2, spany*2 + spanx*13/8 + 10 );
	context.fillText ( "4#集电线", spanx*10-metrics.width/2, spany*2 + spanx*13/8 + 10 );
	context.fillText ( "5#集电线", spanx*11-metrics.width/2, spany*2 + spanx*13/8 + 10 );
	context.fillText ( "1#电容器", spanx*11/2+spanx/3-metrics.width/2, spany*2 + spanx*13/8 + 10 );
	context.fillText ( "2#电容器", spanx*7-metrics.width/2, spany*2 + spanx*13/8 + 10 );
	metrics = context.measureText ( "磁控电抗器" );
	context.fillText ( "磁控电抗器", spanx*11/2-spanx/3-metrics.width/2, spany*2 + spanx*13/8 + 10 );
	context.font = '22px YaHei Consolas Hybrid';
	metrics = context.measureText ( "大连驼山主接线" );
	context.fillText ( "大连驼山主接线", can.width/2-metrics.width/2, 10 );
	//context.fillText ( "中电投东北新能源有限发展公司大连驼山风力发电厂电气一次主接线系统图", spanx/2, spany/8 );
}


function DrawGround ( context, startx, starty, width ) {
	context.beginPath ();
	context.moveTo ( startx, starty );
	context.lineTo ( startx, starty + width );
	context.moveTo ( startx - width/2, starty + width );
	context.lineTo ( startx + width/2, starty + width );
	context.moveTo ( startx - width/3, starty + width*6/5 );
	context.lineTo ( startx + width/3, starty + width*6/5 );
	context.moveTo ( startx - width/6, starty + width*7/5 );
	context.lineTo ( startx + width/6, starty + width*7/5 );
	context.closePath ();
	context.stroke ();
}
function DrawArrow ( context, startx, starty, endx, endy, width ) {
	context.beginPath ();
	var flag = 1;
	var arg = Math.atan ( (endy - starty)/(endx - startx) );
	if ( endx > startx && endy > starty ) flag = -1;
	else if ( endx > startx && endy < starty ) flag = -1;
	else if ( endx < startx && endy < starty ) flag = 1;
	else if ( endx < startx && endy > starty ) flag = 1;
	else if ( endx > startx && endy == starty ) flag = -1;
	else if ( endx == startx && endy < starty ) flag = -1;
	else if ( endx == startx && endy > starty ) flag = -1;
	context.moveTo ( startx, starty );
	context.lineTo ( endx, endy );
	context.lineTo ( endx + flag*width*Math.cos(arg-Math.PI/6), endy + flag*width*Math.sin(arg-Math.PI/6) );
	context.moveTo ( endx, endy );
	context.lineTo ( endx + flag*width*Math.cos(arg+Math.PI/6), endy + flag*width*Math.sin(arg+Math.PI/6) );
	context.closePath ();
	context.stroke ();
}

function DrawCapacitor ( context, startx, starty, width ) {
	context.beginPath ();
	context.moveTo ( startx, starty );
	context.lineTo ( startx, starty + width );
	context.moveTo ( startx-width/2, starty + width );
	context.lineTo ( startx+width/2, starty + width );
	context.moveTo ( startx-width/2, starty + width*4/3 );
	context.lineTo ( startx+width/2, starty + width*4/3 );
	context.moveTo ( startx, starty + width*4/3 );
	context.lineTo ( startx, starty + width*2 );
	context.arc ( startx, starty + width*7/3, width/3, -Math.PI/2, 0, true );
	context.moveTo ( startx+width/3, starty + width*7/3 );
	context.lineTo ( startx, starty + width*7/3 );
	context.lineTo ( startx, starty + width*4 );
	context.moveTo ( startx - width/3, starty + width*4 );
	context.lineTo ( startx + width/3, starty + width*4 );


	context.closePath ();
	context.stroke ();
}



function DrawInductor ( context, startx, starty, width ) {
	context.beginPath ();
	context.moveTo ( startx, starty );
	context.lineTo ( startx, starty + width );
	context.moveTo ( startx - width/4, starty + width );
	context.lineTo ( startx - width/4, starty + width*2 );
	context.lineTo ( startx + width/4, starty + width*2 );
	context.lineTo ( startx + width/4, starty + width );
	context.lineTo ( startx - width/4, starty + width );
	context.moveTo ( startx, starty + width*2 );
	context.lineTo ( startx, starty + width*3 );
	context.closePath ();
	context.stroke ();
	DrawArrow ( context, startx, starty+width*3, startx, starty+width*4, width/3 );
	DrawArrow ( context, startx - width/2, 
						 starty + width*5/2, 
						 startx + width/2, 
						 starty + width/2, width/5 );
}

function DrawResistor ( context, startx, starty, width, hasarrow ) {
	context.beginPath ();
	context.moveTo ( startx, starty );
	context.lineTo ( startx, starty + width );
	context.moveTo ( startx - width/4, starty + width );
	context.lineTo ( startx - width/4, starty + width*2 );
	context.lineTo ( startx + width/4, starty + width*2 );
	context.lineTo ( startx + width/4, starty + width );
	context.lineTo ( startx - width/4, starty + width );
	context.moveTo ( startx, starty + width*2 );
	context.lineTo ( startx, starty + width*3 );
	context.closePath ();
	context.stroke ();
	if ( hasarrow ) DrawArrow ( context, startx, starty + width, startx, starty + width*18/10, width/5 );
}
function DrawSwitch ( context, startx, starty, width ) {
	context.beginPath ();
	context.arc ( startx, starty + width*2, 1, 0, Math.PI*2, true );
	context.moveTo ( startx, starty );
	context.lineTo ( startx, starty + width );
	context.moveTo ( startx - width/8, starty + width );
	context.lineTo ( startx + width/8, starty + width );
	context.moveTo ( startx - width/4, starty + width*9/8 );
	context.lineTo ( startx, starty + width*2 );
	context.moveTo ( startx, starty + width*2 );
	context.lineTo ( startx, starty + width*3 );
	context.closePath ();
	context.stroke ();
}
function DrawMainSwitch ( context, startx, starty, width ) {
	DrawSwitch ( context, startx, starty, width );
	DrawSwitch ( context, startx + width*3/2, starty+width*5/2, width );
	DrawGround ( context, startx + width*3/2, starty+width*9/2, width );
	DrawResistor ( context, startx, starty+width*2, width, false );
	DrawSwitch ( context, startx, starty+width*4, width );
	DrawSwitch ( context, startx - width*3/2, starty+width*9/2, width );
	DrawGround ( context, startx - width*3/2, starty+width*13/2, width );
	context.beginPath ();
	context.moveTo ( startx, starty + width*5/2 );
	context.lineTo ( startx + width*3/2, starty + width*5/2 );
	context.moveTo ( startx, starty+width*9/2 );
	context.lineTo ( startx - width*3/2, starty+width*9/2 );
	context.closePath ();
	context.stroke ();
}
function DrawCollectLine ( context, startx, starty, width, two ) {
	DrawResistor ( context, startx - width*3/2, starty, width, true );
	DrawGround ( context, startx - width*3/2, starty+width*2, width );
	if ( two == 1 ) {
		DrawSwitch ( context, startx + width*3/2, starty, width );
		DrawGround ( context, startx + width*3/2, starty+width*2, width );
	} else if ( two == 2 ) {
		DrawSwitch ( context, startx + width*3/2, starty, width );
		DrawGround ( context, startx + width*3/2, starty+width*2, width );
	} else if ( two == 3 ) {
		DrawSwitch ( context, startx + width*3/2, starty, width );
		DrawGround ( context, startx + width*3/2, starty+width*2, width );
		DrawInductor ( context, startx, starty, width );
	} else if ( two == 4 ) {
		DrawSwitch ( context, startx + width*3/2, starty, width );
		DrawGround ( context, startx + width*3/2, starty+width*2, width );
		DrawCapacitor ( context, startx, starty, width );
	}
	context.beginPath ();

	if ( two == 1 ) {
		context.moveTo ( startx - width*3/2, starty );
		context.lineTo ( startx + width*3/2, starty );
	    context.moveTo ( startx, starty - width );
		context.lineTo ( startx, starty + width*5 );
		context.lineTo ( startx-width/3, starty + width*11/2 );
		context.lineTo ( startx+width/3, starty + width*11/2 );
		context.lineTo ( startx, starty + width*5 );
		context.moveTo ( startx, starty + width*11/2 );
		context.lineTo ( startx, starty + width*7 );
	} else if ( two == 2 ) {
		context.moveTo ( startx - width*3/2, starty );
		context.lineTo ( startx + width*3/2, starty );
	    context.moveTo ( startx, starty - width );
		context.lineTo ( startx, starty + width*5 );
	} else if ( two == 3 ) {
		context.moveTo ( startx - width*3/2, starty );
		context.lineTo ( startx + width*3/2, starty );
	} else if ( two == 4 ) {
		context.moveTo ( startx - width*3/2, starty );
		context.lineTo ( startx + width*3/2, starty );
	} else {
		context.moveTo ( startx - width*3/2, starty );
		context.lineTo ( startx, starty );
	    context.moveTo ( startx, starty - width );
		context.lineTo ( startx, starty + width*7 );
	}

	context.closePath ();
	context.stroke ();
}

function DrawCollector ( context, startx, starty, width ) {
	context.beginPath ();
	context.moveTo ( startx, starty );
	context.lineTo ( startx - width/2, starty + width/2 );
	context.moveTo ( startx, starty );
	context.lineTo ( startx + width/2, starty + width/2 );
	context.moveTo ( startx, starty + width/2 );
	context.lineTo ( startx - width/2, starty + width );
	context.moveTo ( startx, starty + width/2 );
	context.lineTo ( startx + width/2, starty + width );
	context.moveTo ( startx - width/2, starty + width*3/2 );
	context.lineTo ( startx + width/2, starty + width*5/2 );
	context.moveTo ( startx + width/2, starty + width*3/2 );
	context.lineTo ( startx - width/2, starty + width*5/2 );
	context.moveTo ( startx, starty + width/2 );
	context.lineTo ( startx, starty + width*2 );
	context.moveTo ( startx, starty + width*5 );
	context.lineTo ( startx - width/2, starty + width*9/2 );
	context.moveTo ( startx, starty + width*5 );
	context.lineTo ( startx + width/2, starty + width*9/2 );
	context.moveTo ( startx, starty + width*9/2 );
	context.lineTo ( startx - width/2, starty + width*4 );
	context.moveTo ( startx, starty + width*9/2 );
	context.lineTo ( startx + width/2, starty + width*4 );
	context.moveTo ( startx, starty + width*9/2 );
	context.lineTo ( startx, starty + width*7/2 );
	context.moveTo ( startx - width*2/3, starty + width*6/2 );
	context.lineTo ( startx, starty + width*7/2 );
	context.closePath ();
	context.stroke ();
}

function DrawMainTransfer ( context, startx, starty, width ) {
	context.beginPath ();

	context.arc ( startx, starty+width, width, 0, Math.PI*2, true );
	context.moveTo ( startx + width, starty+width*5/2 );
	context.arc ( startx, starty+width*5/2, width, 0, Math.PI*2, true );

	context.moveTo ( startx, starty + width );
	context.lineTo ( startx, starty + width/2 );
	context.moveTo ( startx, starty + width );
	context.lineTo ( startx + width/2*Math.cos(Math.PI/6), starty + width + width/2*Math.sin(Math.PI/6) );
	context.moveTo ( startx, starty + width );
	context.lineTo ( startx - width/2*Math.cos(Math.PI/6), starty + width + width/2*Math.sin(Math.PI/6) );

	context.moveTo ( startx, starty + width*2 );
	context.lineTo ( startx + width/2*Math.cos(Math.PI/6), starty + width*5/2 + width/2*Math.sin(Math.PI/6) );
	context.lineTo ( startx - width/2*Math.cos(Math.PI/6), starty + width*5/2 + width/2*Math.sin(Math.PI/6) );
	context.lineTo ( startx, starty + width*2 );

	context.moveTo ( startx, starty + width );
	context.lineTo ( startx + width*5, starty + width );
	context.moveTo ( startx + width*3, starty + width*4 );
	context.lineTo ( startx + width*5, starty + width*4 );

	context.closePath ();
	context.stroke ();

	DrawResistor ( context, startx + width*3, starty+width, width, true );
	DrawSwitch ( context, startx + width*5, starty+width, width );
	DrawGround ( context, startx + width*3, starty + width*7/2, width );
	DrawArrow ( context, startx+width*4, starty+width, startx+width*4, starty+width*2, width/5 );
	DrawArrow ( context, startx+width*4, starty+width*4, startx+width*4, starty+width*6/2, width/5 );
}
</script>

    </body>
</html>
