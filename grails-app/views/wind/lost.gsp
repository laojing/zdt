<!doctype html>
<html>
    <head> <meta name="layout" content="main"/> </head>

    <body>

	<div class="mainpage">
    <div class="container">
	<asset:javascript src="curve.js"/>

<div class="panel panel-default">
  <!-- Default panel contents -->
  <div class="panel-heading">总览</div>
	<div class="form-group">
		<label for="sel_windField" class="sr-only">机组:</label>
		<div class="input-group">
			<div class="input-group-addon">机组</div>
			<select id="turbinenum" name="windField" class="form-control">
			</select>
		</div>
	</div>

	<table style="height:100%;" class="table table-striped table-bordered table-condensed table-hover">
		<tr>
			<td style="text-align:right;">额定功率（kw）</td>
			<td style="min-width: 50px;"></td>
			<td style="text-align:right;">有功功率（kw）</td>
			<td style="min-width: 50px;"></td>
		</tr>
		<tr>
			<td style="text-align:right;">偏航误差角（°）</td>
			<td style="min-width: 50px;"></td>
			<td style="text-align:right;">偏航功率耗损（kw）</td>
			<td style="min-width: 50px;"></td>
		</tr>
		<tr>
			<td style="text-align:right;">月偏航功率耗损（kw）</td>
			<td style="min-width: 50px;"></td>
			<td style="text-align:right;">累计偏航功率耗损（kw）</td>
			<td style="min-width: 50px;"></td>
		</tr>
		<tr>
			<td colspan="3" style="text-align:right;" class="danger">
				<span class="glyphicon glyphicon-warning-sign"></span>
				累计偏航功率耗损最大发电机组
			</td>
			<td style="min-width: 50px;"></td>
		</tr>
	</table>
</div>

<div class="panel panel-default">
  <!-- Default panel contents -->
  <div class="panel-heading">曲线</div>
  <div id="canlostparent">
   <canvas id="canlost"></canvas>
   </div>
</div>
   </div>
   </div>
<script>

function DrawWindLost ( parentdiv, canid ) {

	var can = document.getElementById ( canid );
	var context = can.getContext ( '2d' );

	can.width = 0; 
	can.height = 0;
	can.width = parentdiv.width();
	can.height = parentdiv.height();

	drawYLabel ( context, can.width, can.height, 10, 25, 0, 60, 35, 4, 5, "%.0f", 0.8, lineColorsPowers[0], 0, 100, '功率(MW)' );
	drawXLabel ( context, can.width, can.height, 10, 25, 60, 35, 3, 3, "%.0f", 0.8, '#666666', new Date()-(3600*24*1000), new Date(), '', 1 );

	//drawLine ( context, can.width, can.height, 10, 25, 115, 35, 1.8, lineColorsPowers[0], new Date()/1000-(3600*24), new Date()/1000, 0, 100000, data1 );
	//drawLine ( context, can.width, can.height, 10, 25, 115, 35, 1.8, lineColorsPowers[1], new Date()/1000-(3600*24), new Date()/1000, 0, 20, data2 );

}


function resizeHome() {
	var height = $(window).height();		
	var width = $(window).width();		

	if ( height > 400 && width > 970 ) {
		$('#canlostparent').height ( height - 430 );
	} else {
		$('#canlostparent').height ( width/2 );
	}

	DrawWindLost( $('#canlostparent'), 'canlost' );
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
