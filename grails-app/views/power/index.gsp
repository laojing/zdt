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

	<div class="row">
	<div class="col-lg-4 col-md-12">
	<div id="powerrank" class="panel">
	    <div class="panel-heading">功率特性表现</div>
		<div class="content">
			<table id="effi" class="suttable" style="height:100%;width:100%;">
			<tr><td><img src="${assetPath(src: 'rank1.png')}"/></td><td><span id="effit1"></span></td><td><span id="effi1"></span></td></tr>
			<tr><td><img src="${assetPath(src: 'rank2.png')}"/></td><td><span id="effit2"></span></td><td><span id="effi2"></span></td></tr>
			<tr><td><img src="${assetPath(src: 'rank3.png')}"/></td><td><span id="effit3"></span></td><td><span id="effi3"></span></td></tr>
			<tr><td colspan="3"><a href="${createLink(action:'effi',controller:'power')}">查看全部</a></td></tr>
			<tr><td><img src="${assetPath(src: 'rank-3.png')}"/></td><td><span id="effit-3"></span></td><td><span id="effi-3"></span></td></tr>
			<tr><td><img src="${assetPath(src: 'rank-2.png')}"/></td><td><span id="effit-2"></span></td><td><span id="effi-2"></span></td></tr>
			<tr><td><img src="${assetPath(src: 'rank-1.png')}"/></td><td><span id="effit-1"></span></td><td><span id="effi-1"></span></td></tr>
			</table>
		</div>
	</div>
	</div>

	<div class="col-lg-8 col-md-12">
	<div id="powerreal" class="panel">
	    <div class="panel-heading">风场总功率曲线</div>
		<div class="content" id="canrealparent">
		<canvas id="canreal" width="100%" height="100%"></canvas>
		</div>
	</div>
	</div>

	</div>

	<div class="row">
	<div class="col-lg-4 col-md-12">
	<div id="powererror" class="panel">
	    <div class="panel-heading">故障预警</div>
			<center> <h6 id="badtitle"></h6> </center>
		<div class="content" id="canerrorparent">
			<canvas id="canerror" width="100%" height="100%"></canvas>
		</div>
	</div>
	</div>
	
	<div class="col-lg-8 col-md-12">
	<div id="powercheck" class="panel">
	    <div class="panel-heading">功率曲线查询</div>
		<div class="content">
			<div class="row" style="height:100%;">
				<div class="col-xs-12 col-lg-4" style="height:100%;">
					<table class="suttable" style="height:100%;width:100%;">
					<tr><td>开始：</td><td>
						<div class="input-group date form_datetime" id="start_time" data-date="2015-08-16" data-date-format="dd MM yyyy - HH:ii" data-link-field="dtp_start">
							<input class="form-control" id="start_time_in" size="6" type="text" value="2015-08-10 00:00:00" readonly>
							<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						</div>
						<input type="hidden" id="dtp_start" value="2015-08-10 00:00:00" />
					</td></tr><tr><td>结束：</td><td>
						<div class="input-group date form_datetime" id="end_time" data-date="2015-09-01" data-date-format="dd MM yyyy - HH:ii" data-link-field="dtp_end">
							<input class="form-control" id="end_time_in" size="6" type="text" value="2015-08-30 00:00:00" readonly>
							<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						</div>
						<input type="hidden" id="dtp_end" value="2015-08-30 00:00:00" />
					</td></tr><tr><td>风机：</td><td>
							<select id="turbinenum" class="form-control"></select>
					</td></tr><tr><td align="center" colspan="2">
						<button type="button" class="btn btn-primary" onclick=PowerCheck()>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查询&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</td></tr>
					</table>
				</div>

				<div class="col-xs-12 col-lg-8" id="cancheckparent" style="height:100%;">
				<canvas id="cancheck" width="100%" height="100%"></canvas>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	
	</div>
	</div>

<script>

var checkdata = new Array();
var urlpower = "${createLink(controller='power',action:'getupdatedata')}";

function UpdateOver() {
	UpdatePowerMain( urlpower, $('#canrealparent'), 'canreal', $('#canerrorparent'), 'canerror' );
	window.setTimeout ( UpdateOver, UPDATESPAN );
}

function resizeHome() {
	var height = $(window).height();		
	var width = $(window).width();		
	if ( height > 400 && width > 970 ) {
		var clientheight = height - 190;
		$('#powerrank > .content').height( clientheight/2 );
		$('#powerreal > .content').height( clientheight/2 );
		$('#powererror > .content').height( clientheight/2 );
		$('#powercheck > .content').height( clientheight/2 );
	} else {
		$('#powerrank > .content').height( 200 );
		$('#powerreal > .content').height( width/2 );
		$('#powererror > .content').height( width/2 );
		$('#powercheck > .content').height( width/2 );
	}
	PowerCheck();
}
	
function PowerCheck() {
	var start = $('#dtp_start').val();
	start = start.replace ( '-', '/' ).replace ( '-', '/' );
	var end = $('#dtp_end').val();
	end = end.replace ( '-', '/' ).replace ( '-', '/' );
	$.getJSON("${createLink(controller='power',action:'getlinedata')}", 
	{turbinenum:$('#turbinenum').val(),start:new Date(start).getTime()/1000,end:new Date(end).getTime()/1000},
	function(data) {
		for ( var i=0; i<data.total.length; i++ ) {
			checkdata[i] = {x:data.total[i].w,y:data.total[i].p};
		}
		DrawPowerCheck ( $('#cancheckparent'), 'cancheck', checkdata );
	});
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

	resizeHome();
	UpdateOver();
});
$(window).resize(function(){
	resizeHome();
});

</script>

    </body>
</html>
