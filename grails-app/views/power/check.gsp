<!doctype html>
<html>
    <head> <meta name="layout" content="main"/> </head>
    <body>
  	<asset:stylesheet src="bootstrap-datetimepicker.min.css"/>
	<asset:javascript src="bootstrap-datetimepicker.js"/>
	<asset:javascript src="bootstrap-datetimepicker.zh-CN.js"/>
	<asset:javascript src="curve.js"/>
	<asset:javascript src="power.js"/>

	<div class="mainpage">
	<div class="container">

<div style="position:absolute;right:60px;bottom:80px;z-index:10">
<label class="checkbox-inline">
  <input onchange="DispChange();" type="checkbox" id="distype1" value="option1" checked> 金风标准
</label>
<label class="checkbox-inline">
  <input onchange="DispChange();" type="checkbox" id="distype2" value="option2"> 东汽标准
</label>
</div>

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
						<button type="button" class="btn btn-primary" onclick=addLine()>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;增加曲线&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</td></tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	</div>

	<div class="col-lg-9 col-md-12">
	<div id="variables" class="panel">
		<div class="panel-heading">已选列表</div>
		<div class="content" style="margin:0 20px;"><table style="height:100%;width:100%;" id="curvelist" class="suttable"></table></div>
	</div>
	</div>
	</div>
	
	<div class="row">
	<div class="col-lg-12 col-md-12">
	<div id="curves" class="panel">
		<div class="panel-heading">曲线对比</div>
		<div class="content" id="cancheckparent">
		<canvas id="cancheck"></canvas>
		</div>
	</div>
	</div>
	</div>

	</div>
	</div>

<script>

var urlpower = "${createLink(controller='power',action:'getupdatedata')}";
var lineMax = 6;
var lineColors = ['#000040', '#004000', '#2000a0',
				'#800020', '#202040', '#8020a0'];

var hash;

function addLine () {
	var rowcount = $('#curvelist >tbody >tr').length;
	if ( rowcount >= lineMax ) return;

	var linetype = $('#turbinenum').val();
	for ( var i=0; i<rowcount; i++ ) {
		var tr = $('#curvelist >tbody >tr')[i];
		tr.children[0].style.color = lineColors[i];
		if ( tr.getAttribute('data-type') == linetype ) {
			linetype = linetype + '1';
		}
	}

	$('#curvelist').append ('<tr data-type="'+linetype+'" data-turbine="'+$('#turbinenum').val()+'">' 
			+ '<td width="160px" style="color:'+lineColors[rowcount]+';"><span id="title'+linetype+'">'+GetTurbName($('#turbinenum').val())+'</span></td>'
			+ '<td width="150px">'+$('#dtp_start').val()+'</td>'
			+ '<td width="150px">'+$('#dtp_end').val()+'</td>'
			+ '<td width="30px"><a onclick=DelLine(\''+linetype+'\') class="btn btn-default btn-xs" role="button">删除</a></td></tr>');
	var start = $('#dtp_start').val();
	start = start.replace ( '-', '/' ).replace ( '-', '/' );
	var end = $('#dtp_end').val();
	end = end.replace ( '-', '/' ).replace ( '-', '/' );
	GetLineData ( $('#turbinenum').val(), start, end, linetype );
}
function DelLine ( linetype ) {
	var rowcount = $('#curvelist >tbody >tr').length;
	for ( var i=rowcount-1; i>=0; i-- ) {
		var row = $('#curvelist >tbody >tr').eq(i);
		if ( row.attr('data-type') == linetype ) {
			row.remove();
		}
	}
	rowcount = $('#curvelist >tbody >tr').length;
	for ( var i=0; i<rowcount; i++ ) {
		var tr = $('#curvelist >tbody >tr')[i];
		tr.children[0].style.color = lineColors[i];
	}
	DrawPowerCompare( $('#cancheckparent'), "cancheck", hash );
}

var linenumber = 0;
function GetLineData ( turbinenum, start, end, linetype ) {
	$.getJSON("${createLink(controller='power',action:'getlinedata')}", 
	{turbinenum:turbinenum,start:new Date(start).getTime()/1000,end:new Date(end).getTime()/1000},
	function(data) {
		var line = {max:0, min:0, title:'', unit:'', data:0};
		line.data = new Array();

		var powers = 0;
		linenumber++;
		for ( var i=0; i<data.total.length; i++ ) {
			line.data[i] = {x:data.total[i].w,y:data.total[i].p};
			powers += data.total[i].p;
		}
		if ( powers == 0 ) {
			if ( linenumber == 1 ) alert ( '数据库更新错误！所有数值只是页面展示作用！' );
			for ( var i=0; i<50; i++ ) {
				line.data[i] = {x:i/2,y:i<22?i*(50+linenumber):1480};
			}
		}
		line.title = $('#title'+linetype).html();
		line.unit = '(kW)';
		hash[linetype] = line;
		DrawPowerCompare( $('#cancheckparent'), "cancheck", hash );
	});
}

function resizeHome() {

	var height = $(window).height();		
	var width = $(window).width();		
	if ( height > 400 && width > 970 ) {
		var clientheight = height - 180;
		$('#condition > .content').height( clientheight/3 );
		$('#variables > .content').height( clientheight/3 );
		$('#curves > .content').height( clientheight*2/3 );
	} else {
		$('#condition > .content').height( 200 );
		$('#variables > .content').height( 200 );
		$('#curves > .content').height( width/2 );
	}

}

var disptype1 = true;
var disptype2 = false;
var stand1 = new Array();
var stand2 = new Array();

function DispChange () {
	if ( document.getElementById('distype1').checked ) disptype1 = true;
	else disptype1 = false;
	if ( document.getElementById('distype2').checked ) disptype2 = true;
	else disptype2 = false;
	DrawPowerCompare( $('#cancheckparent'), "cancheck", hash );
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
	var starttime = new Date( end.getTime() - 10*24*60*60*1000 );

	$('#end_time_in').val( end.Format('yyyy-MM-dd hh:mm:ss') );
	$('#dtp_end').val( end.Format('yyyy-MM-dd hh:mm:ss') );

	$('#start_time_in').val( starttime.Format('yyyy-MM-dd hh:mm:ss') );
	$('#dtp_start').val( starttime.Format('yyyy-MM-dd hh:mm:ss') );

	hash = new Object();
	resizeHome();

	$.getJSON("${createLink(controller='power',action:'getstand')}", function(data) {
		for ( var i=0; i<data.stand1.length; i++ ) {
			stand1[i] = {x:data.stand1[i].wind,y:data.stand1[i].power};
		}
		for ( var i=0; i<data.stand2.length; i++ ) {
			stand2[i] = {x:data.stand2[i].wind,y:data.stand2[i].power};
		}
		addLine();
	});

});

$(window).resize(function(){
	resizeHome();
});

</script>

	</body>
</html>
