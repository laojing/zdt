<!doctype html>
<html>
    <head> <meta name="layout" content="main"/> </head>
    <body>
	<asset:javascript src="follow.js"/>
		<div class="mainpage">
		<div class="container">
<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div id="canfollowparent">
		<canvas id="canfollow" width="100%" height="100%"></canvas>
		</div>
</div>
</div>

<div class="row">

<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
<div class="panel panel-default" id="canline1parent">
</div>
</div>



<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
<div class="panel panel-default" id="canline2parent">
  <div class="panel-heading">2#集电线</div>
</div>
</div>

<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
<div class="panel panel-default" id="canline3parent">
  <div class="panel-heading">3#集电线</div>
</div>
</div>

<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
<div class="panel panel-default">
  <div class="panel-heading">电容器</div>
  <div class="panel-body">
  <div id="capvar"></div>
  </div>
</div>
</div>

<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
<div class="panel panel-default" id="canline4parent">
</div>
</div>
<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
<div class="panel panel-default" id="canline5parent">
</div>
</div>

</div>

		</div>
		</div>
<script>

function resize() {
	var height = $(window).height();		
	var width = $(window).width();		

	//$('#canfollowparent').width ( width );
	//$('#canfollowparent').height ( width*5/48 );

	DrawFollowDist( $('#canfollowparent'), 'canfollow' );
}
function InsertLineTurbine ( obj, index, lines ) {
	var cont = '<div class="panel-heading">'+index+'#集电线</div>';
	cont += '<div class="row">';
	for ( var i=0; i<lines.length; i++ ) {
		cont += '<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">';
		cont += '<table class="followtable" style="width:100%;">';
		cont += '<tr><th colspan="2">'+lines[i]+'号机组</th></tr>';
		cont += '<tr><td>有功</td><td><span id="fpower'+lines[i]+'">-kW</span></td></tr>';
		cont += '<tr><td>无功</td><td><span id="fvar'+lines[i]+'">-kVar</span></td></tr>';
		cont += '<tr><td>给定</td><td><span id="fvarset'+lines[i]+'">-kVar</span></td></tr>';
		cont += '</table></div>';
	}
	cont += '</div>';
	obj.html ( cont );
}
	
function InsetAllTurbine() {
	var line1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
	var line2 = [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22];
	var line3 = [23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];
	var line4 = [34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48];
	var line5 = [49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 61, 62, 63, 64, 65, 66];

	InsertLineTurbine ( $('#canline1parent'), 1, line1 );
	InsertLineTurbine ( $('#canline2parent'), 2, line2 );
	InsertLineTurbine ( $('#canline3parent'), 3, line3 );
	InsertLineTurbine ( $('#canline4parent'), 4, line4 );
	InsertLineTurbine ( $('#canline5parent'), 5, line5 );
}

var urlpower = "${createLink(controller='follow',action:'getupdatedata')}";
function UpdateOver() {
	UpdatePowerMain( urlpower );
	window.setTimeout ( UpdateOver, UPDATESPAN );
}

$(document).ready(function(){
	resize();
	InsetAllTurbine();
	UpdateOver();
});

$(window).resize(function(){
	resize();
});

function DrawFollowDist ( parentdiv, canid ) {
	var can = document.getElementById ( canid );
	var context = can.getContext ( '2d' );
	parentdiv.height ( parentdiv.width()*5/48 );

	can.width = 0, can.height = 0;
	can.width = parentdiv.width();
	can.height = parentdiv.height();

	var spanx = can.width/12;

	context.textBaseline = "top";
	context.font = '12px YaHei Consolas Hybrid';
	var metrics = context.measureText ( "220kV母线" );
	context.fillText ( "220kV母线", 0, spanx/8+10 );
	context.textBaseline = "bottom";
	context.fillText ( "35kV一段母线", 0, spanx-10 );
	metrics = context.measureText ( "35kV一段母线" );
	context.fillText ( "35kV二段母线", can.width-metrics.width, spanx-10 );

	context.beginPath ();
	context.moveTo ( 0, spanx/8 );
	context.lineTo ( can.width, spanx/8 );

	context.moveTo ( can.width/2, spanx/8 );
	context.lineTo ( can.width/2, spanx/4 );
	context.moveTo ( can.width/2, spanx*5/8 );
	context.lineTo ( can.width/2, spanx*6/8 );

	context.moveTo ( spanx*3 , spanx*6/8 );
	context.lineTo ( spanx*10, spanx*6/8 );

	context.moveTo ( spanx*3 , spanx*6/8 );
	context.lineTo ( spanx*3, spanx );
	context.moveTo ( spanx*7 , spanx*6/8 );
	context.lineTo ( spanx*7, spanx*10/8 );
	context.moveTo ( spanx*10 , spanx*6/8 );
	context.lineTo ( spanx*10, spanx );

	context.moveTo ( 0, spanx );
	context.lineTo ( spanx*5, spanx );

	context.moveTo ( spanx*18/2 , spanx );
	context.lineTo ( spanx*12, spanx );

	//one
	context.moveTo ( spanx, spanx );
	context.lineTo ( spanx, spanx*10/8 );
	//two
	context.moveTo ( spanx*3, spanx );
	context.lineTo ( spanx*3, spanx*10/8 );
	//three
	context.moveTo ( spanx*5, spanx );
	context.lineTo ( spanx*5, spanx*10/8 );
	//four
	context.moveTo ( spanx*9, spanx );
	context.lineTo ( spanx*9, spanx*10/8 );
	//five
	context.moveTo ( spanx*11, spanx );
	context.lineTo ( spanx*11, spanx*10/8 );

	context.closePath ();
	context.lineWidth = 1.5;
	context.stroke ();
	DrawMainTransfer ( context, can.width/2, spanx/4, spanx/8 );
}

function DrawMainTransfer ( context, startx, starty, width ) {
	context.beginPath ();
	context.arc ( startx, starty+width, width, 0, Math.PI*2, true );
	context.moveTo ( startx + width, starty+width*4/2 );
	context.arc ( startx, starty+width*4/2, width, 0, Math.PI*2, true );
	context.closePath ();
	context.stroke ();
}

</script>

    </body>
</html>
