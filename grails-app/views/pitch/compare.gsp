<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>中电投风电场优化系统</title>
	</head>
	<body>
  	<asset:stylesheet src="bootstrap-datetimepicker.min.css"/>
	<asset:javascript src="bootstrap-datetimepicker.js"/>
	<asset:javascript src="bootstrap-datetimepicker.zh-CN.js"/>
	<asset:javascript src="column.js"/>

	<div class="mainpage">
	<div class="container">

	<div class="row">
	<div class="col-lg-3 col-md-12">
	<div id="condition" class="panel">
		<div class="panel-heading">数据点选择</div>
		<div class="content">
			<div class="row" style="height:100%;">
				<div class="col-xs-12 col-lg-12" style="height:100%;">
					<table class="suttable" style="height:100%;width:95%;">
					<tr><td>开始：</td><td>
						<div class="input-group date form_datetime" data-date="2015-08-16T05:25:07Z" data-date-format="dd MM yyyy - HH:ii" data-link-field="dtp_start">
							<input class="form-control" id="start_time_in" size="6" type="text" value="2015-08-20 00:00:00" readonly>
							<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						</div>
						<input type="hidden" id="dtp_start" value="2015-08-20 00:00:00" />
					</td></tr><tr><td>结束：</td><td>
						<div class="input-group date form_datetime" data-date="2015-09-01T05:25:07Z" data-date-format="dd MM yyyy - HH:ii" data-link-field="dtp_end">
							<input class="form-control" id="end_time_in" size="6" type="text" value="2015-08-28 00:00:00" readonly>
							<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						</div>
						<input type="hidden" id="dtp_end" value="2015-08-28 00:00:00" />
					</td></tr><tr><td>风机：</td><td>
							<select id="turbinenum" class="form-control"></select>
					</td></tr><tr><td align="center" colspan="2">
						<button type="button" class="btn btn-primary" onclick=addLine()>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更新&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</td></tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	</div>

	<div class="col-lg-9 col-md-12">
	<div id="variables" class="panel">
		<div class="panel-heading">同比</div>
		<div class="content" id="canselfparent">
		<canvas id="canself"></canvas>
		</div>
	</div>
	</div>
	</div>
	
	<div class="row">
	<div class="col-lg-12 col-md-12">
	<div id="curves" class="panel">
		<div class="panel-heading">环比</div>

<table width="100%"><tr><td>
<select id="turbinetime" class="form-control"></select>
  </td><td>
	<select id="turbinetype" class="form-control"> 
		<option value="1">金风机组</option>
		<option value="2">东气机组</option>
	</select>
  </td><td>
<button type="button" class="btn btn-primary" onclick=delLine()>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更新&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
</td></tr></table>

		<div class="content" id="cancheckparent">
		<canvas id="cancheck"></canvas>
		</div>
	</div>
	</div>
	</div>
	
	</div>
	</div>
	<script>
var lineMax = 6;
var lineColors = ['#000040', '#004000', '#2000a0',
				'#800020', '#202040', '#8020a0'];

var varturbinenum = 0;
var varturbinetype = 0;
var span = 60*60*24*7*1000;

function addLine () {
	var start = $('#dtp_start').val();
	start = start.replace ( '-', '/' ).replace ( '-', '/' );
	var end = $('#dtp_end').val();
	end = end.replace ( '-', '/' ).replace ( '-', '/' );
	GetLineData ( $('#turbinenum').val(), start, end );
}

function GetLineData ( turbinenum, start, end ) {
	varturbinenum = turbinenum;
	$.getJSON("${createLink(controller='pitch',action:'getlinedata')}", 
	{turbinenum:turbinenum,start:new Date(start).getTime()/1000,end:new Date(end).getTime()/1000},
	function(data) {
		DrawSelfCompare( $('#canselfparent'), "canself", data.total );
	});
}

function DrawSelfCompare ( parentdiv, canid, data ) {
	var can = document.getElementById ( canid );
	var context = can.getContext ( '2d' );

	can.width = 0; 
	can.height = 0;
	can.width = parentdiv.width();
	can.height = parentdiv.height();

	if( varturbinenum <= 33 ) {
		drawBackground ( context, can.width, can.height, 20, 65, 70, 40, 4, 12, 0.1, '#666666' );
		drawYLabel ( context, can.width, can.height, 20, 65, 0, 70, 40, 4, 1, "%.0f", 0.8, lineColorsCompare[0], 0, 1600, '转矩系数' );
		drawXLabel ( context, can.width, can.height, 20, 65, 70, 40, data.length, 1, "%.0f", 0.1, '#666666', data, 'm/s', 1 );
	} else {
		drawBackground ( context, can.width, can.height, 20, 65, 70, 40, 4, 12, 0.1, '#666666' );
		drawYLabel ( context, can.width, can.height, 20, 65, 0, 70, 40, 4, 1, "%.4f", 0.8, lineColorsCompare[0], 0, 0.002, '转矩系数' );
		drawXLabel ( context, can.width, can.height, 20, 65, 70, 40, data.length, 1, "%.0f", 0.1, '#666666', data, 'm/s', 1 );
	}
}


function delLine () {
	varturbinetype = $('#turbinetype').val();
	$.getJSON("${createLink(controller='pitch',action:'gettypedata')}", 
	{turbinetime:$('#turbinetime').val(),turbinetype:$('#turbinetype').val()},
	function(data) {
		DrawCheckCompare( $('#cancheckparent'), "cancheck", data.total );
	});
}

function DrawCheckCompare ( parentdiv, canid, data ) {
	var can = document.getElementById ( canid );
	var context = can.getContext ( '2d' );

	can.width = 0; 
	can.height = 0;
	can.width = parentdiv.width();
	can.height = parentdiv.height();

	if( varturbinetype == 1 ) {
		drawBackground ( context, can.width, can.height, 20, 65, 70, 40, 4, 12, 0.1, '#666666' );
		drawYLabel ( context, can.width, can.height, 20, 65, 0, 70, 40, 4, 1, "%.0f", 0.8, lineColorsCompare[0], 0, 1600, '转矩系数' );
		drawXLabel2 ( context, can.width, can.height, 20, 65, 70, 40, data.length, 1, "%.0f", 0.1, '#666666', data, 'm/s', 1 );
	} else if( varturbinetype == 2 ) {
		drawBackground ( context, can.width, can.height, 20, 65, 70, 40, 4, 12, 0.1, '#666666' );
		drawYLabel ( context, can.width, can.height, 20, 65, 0, 70, 40, 4, 1, "%.4f", 0.8, lineColorsCompare[0], 0, 0.002, '转矩系数' );
		drawXLabel2 ( context, can.width, can.height, 20, 65, 70, 40, data.length, 1, "%.0f", 0.1, '#666666', data, 'm/s', 1 );
	}
}

//HighNav ( '变桨距' ); 
function Resize() {
	var height = $(window).height();		
	var width = $(window).width();		
	if ( height > 400 && width > 970 ) {
		var clientheight = height - 180;
		$('#condition > .content').height( clientheight*5/12 );
		$('#variables > .content').height( clientheight*5/12 );
		$('#curves > .content').height( clientheight*7/12 - 30 );
	} else {
		$('#condition > .content').height( 200 );
		$('#variables > .content').height( 200 );
		$('#curves > .content').height( width/2 );
	}
}

$(document).ready(function(){

	for ( var i=1; i<=33; i++ ) {
		$('#turbinenum').append("<option value='"+i+"'>金风"+i+"号机组</option>");
	}
	for ( var i=1; i<=33; i++ ) {
		if ( (i+33 != 59) && (i+33 != 60) )
		$('#turbinenum').append("<option value='"+(i+33)+"'>东汽"+i+"号机组</option>");
	}
    $('.form_datetime').datetimepicker({
        language: 'zh-CN',
        weekStart: 1,
        todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0,
		minuteStep: 10,
        showMeridian: 1
    });

	var end = new Date();
	var starttime = new Date( end.getTime() - 100*24*60*60*1000 );

	$('#end_time_in').val( end.Format('yyyy-MM-dd hh:mm:ss') );
	$('#dtp_end').val( end.Format('yyyy-MM-dd hh:mm:ss') );

	$('#start_time_in').val( starttime.Format('yyyy-MM-dd hh:mm:ss') );
	$('#dtp_start').val( starttime.Format('yyyy-MM-dd hh:mm:ss') );

	var start = 1447084800000;
	var endtime = new Date().getTime();

	while ( endtime > start+span ) {
		var startd = new Date();
		startd.setTime(start);
		var starte = new Date();
		starte.setTime(start+span);
		//$('#turbinetime').append("<option value='"+starte.getTime()/1000+"'>"+startd.toLocaleDateString()+"到"+starte.toLocaleDateString()+"</option>");
		$('#turbinetime').append("<option value='"+starte.getTime()/1000+"'>"+startd.Format('yyyy-MM-dd')+" | "+starte.Format('MM-dd')+"</option>");
		start += span;
	}

	Resize();
	addLine();
	delLine();
});

$(window).resize(function(){
	Resize();
});
	</script>
	</body>
</html>
