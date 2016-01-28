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

	<div class="row">
	<div class="col-lg-4 col-md-12">
	<div id="condition" class="panel">
		<div class="panel-heading">数据点选择</div>
		<div class="content">
			<div class="row" style="height:100%;">
				<div class="col-xs-12 col-lg-12" style="height:100%;">
					<table class="suttable" style="height:100%;width:95%;">
					<tr><td>风机类型：</td><td>
							<select id="turbinetype" class="form-control" onchange="ChangeType(this)">
								<option value="1">金风机组</option>
								<option value="2">东气机组</option>
							</select>
					</td></tr><tr><td>风机序号：</td><td>
							<select id="turbinenum" class="form-control"></select>
					</td></tr><tr><td>时间区间：</td><td>
							<select id="turbinetime" class="form-control"></select>
					</td></tr><tr><td align="center" colspan="2">
						<button type="button" class="btn btn-primary" onclick=addLine()>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;增加曲线&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</td></tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	</div>

	<div class="col-lg-8 col-md-12">
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
var lineMax = 6;
var lineColors = ['#000040', '#004000', '#2000a0',
				'#800020', '#202040', '#8020a0'];

var span = 60*60*24*7*1000;
var hash;

function addLine () {
	var rowcount = $('#curvelist >tbody >tr').length;
	if ( rowcount >= lineMax ) return;

	var linetype = $('#turbinenum').val();
	var title = '金风第' + linetype + '号机组';
	if ( linetype > 33 ) title = '东汽第' + (linetype-33) + '号机组';
	for ( var i=0; i<rowcount; i++ ) {
		var tr = $('#curvelist >tbody >tr')[i];
		tr.children[0].style.color = lineColors[i];
		if ( tr.getAttribute('data-type') == linetype ) {
			linetype = linetype + '1';
		}
	}
	var startd = new Date();
	startd.setTime($('#turbinetime').val()*1000);
	var starte = new Date();
	starte.setTime($('#turbinetime').val()*1000-span);

	$('#curvelist').append ('<tr data-type="'+linetype+'" data-turbine="'+$('#turbinenum').val()+'">' 
			+ '<td width="140px" style="color:'+lineColors[rowcount]+';"><span id="title'+linetype+'">'+title+'</span></td>'
			+ '<td width="150px"><span id="value'+linetype+'"></span></td>'
			+ '<td width="150px" align="right">'+starte.Format('yyyy-MM-dd')+'</td>'
			+ '<td width="150px">-  '+startd.Format('yyyy-MM-dd')+'</td>'
			+ '<td width="40px"><a onclick=DelLine(\''+linetype+'\') class="btn btn-default btn-xs" role="button">删除</a></td></tr>');
	GetLineData ( $('#turbinenum').val(), $('#turbinetime').val(), linetype );
}

var fuck;
function GetLineData ( turbinenum, start, linetype ) {
	$.getJSON("${createLink(controller='pitch',action:'getcmpdata')}", 
	{turbinenum:turbinenum,start:start},
	function(data) {
		fuck = data;
		var timespan = 200;
		var start = 200000;
		var span = 200000/timespan;
		if ( turbtype == 2 ) {
			start = 1500;
			span = 2000/timespan;
		}
		var line = {max:0, min:0, title:'', unit:'', data:0};
		line.data = new Array();
		for ( var i=0; i<timespan; i++ ) {
			var y = start+i*span;
			var x = 0;
			if ( data.curgain[0].optgain > 0 ) x = Math.sqrt(y/data.curgain[0].optgain);
			line.data[i] = {x:x,y:y};
		}

		line.title = $('#title'+linetype).html();
		$('#value'+linetype).html(data.curgain[0].optgain);
		line.unit = '(kW)';
		hash[linetype] = line;
		DrawPowerCompare( "cancheck", hash );
	});
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
	DrawPowerCompare( "cancheck", hash );
}




var turbtype = 1;
function ChangeType ( obj ) {
	turbtype = 1*$('#turbinetype').val();

	$('#turbinenum').html("");
	if ( turbtype == 1 ) {
		for ( var i=1; i<=33; i++ ) {
			$('#turbinenum').append("<option value='"+i+"'>金风"+i+"号机组</option>");
		}
	} else {
		for ( var i=1; i<=33; i++ ) {
			if ( (i+33 != 59) && (i+33 != 60) )
			$('#turbinenum').append("<option value='"+(i+33)+"'>东汽"+i+"号机组</option>");
		}
	}
	var rowcount = $('#curvelist >tbody >tr').length;
	for ( var i=rowcount-1; i>=0; i-- ) {
		var row = $('#curvelist >tbody >tr').eq(i);
		row.remove();
	}
	DrawPowerCompare( "cancheck", hash );
}

function DrawPowerCompare ( obj, data ) {
	var can = document.getElementById ( obj );
	var context = can.getContext ( '2d' );

	var width = $('#cancheckparent').width();
	var height = $('#cancheckparent').height();
	can.width = 0;
	can.height = 0;
	can.width = width;
	can.height = height;

	if ( turbtype == 1 ) {
		drawBackground ( context, width, height, 30, 40, 90, 35, 10, 20, 0.1, '#666666' );
		drawYLabel ( context, width, height, 30, 40, 0, 90, 35, 4, 5, "%.0f", 0.8, lineColors[0], 0, 500000, '转矩(Nm)' );
		drawXLabel ( context, width, height, 30, 40, 90, 35, 5, 4, "%.0f", 0.8, '#666666', 0, 20, '转速(rpm)', 0 );
	} else {
		drawBackground ( context, width, height, 30, 40, 70, 35, 10, 20, 0.1, '#666666' );
		drawYLabel ( context, width, height, 30, 40, 0, 70, 35, 4, 5, "%.0f", 0.8, lineColors[0], 0, 3500, '转矩(Nm)' );
		drawXLabel ( context, width, height, 30, 40, 70, 35, 5, 4, "%.0f", 0.8, '#666666', 0, 2000, '转速(rpm)', 0 );
	}
	
	var rowcount = $('#curvelist >tbody >tr').length;
	for ( var i=0; i<rowcount; i++ ) {
		var tr = $('#curvelist >tbody >tr')[i];
		var type = tr.getAttribute('data-type');
		var cs = data[type];

		if ( turbtype == 1 ) {
			drawLine ( context, width, height, 30, 40, 90, 35, 2, lineColors[i], 0, 20, 0, 500000, cs.data );
		} else {
			drawLine ( context, width, height, 30, 40, 70, 35, 2, lineColors[i], 0, 2000, 0, 3500, cs.data );
		}
	}
}













//HighNav ( '变桨距' ); 
function Resize() {
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


$(document).ready(function(){
	for ( var i=1; i<=33; i++ ) {
		$('#turbinenum').append("<option value='"+i+"'>金风"+i+"号机组</option>");
	}
	var start = 1437321600000;
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
	hash = new Object();
	Resize();
});

$(window).resize(function(){
	Resize();
});
	</script>
	</body>
</html>
