var alarm = 0;

var ttt;
// Main Power
function UpdatePowerMain( url, parentreal, canreal, parenterror, canerror ) {
	$.getJSON(url, function(data) {
		ttt = data.effi.length;
		if ( alarm == 0 && data.effi.length == 0 ) {
			alarm = 1;
			alert ( '数据库更新错误！所有数值只是页面展示作用！' );
		}

		var realwind = new Array();
		var realpower = new Array();
		var midpower = new Array();
		var badpower = new Array();
		if ( data.effi.length > 0 ) {
			for ( var i=0; i<data.real.length; i++ ) {
				realpower[i] = {x:data.real[i].savetime,y:data.real[i].power};
				realwind[i] = {x:data.real[i].savetime,y:data.real[i].wind};
			}
			for ( var i=0; i<data.mid.length; i++ ) {
				midpower[i] = {x:data.mid[i].savetime,y:data.mid[i].power};
			}
			for ( var i=0; i<data.bad.length; i++ ) {
				badpower[i] = {x:data.bad[i].savetime,y:data.bad[i].power};
			}
		} else {
			for ( var i=0; i<66; i++ ) {
				data.effi[i] = {turbnum:i+1,value:0.4-i*0.01};
			}
			var start = new Date()/1000-(3600*24);
			for ( var i=0; i<144; i++ ) {
				realpower[i] = {x:start+i*600,y:20000+(Math.sin(i)*10000)};
				realwind[i] = {x:start+i*600,y:10+(Math.sin(i)*5)};
				midpower[i] = {x:start+i*600,y:800+(Math.sin(i)*10)};
				badpower[i] = {x:start+i*600,y:800+(Math.sin(i)*10)};
			}
			data.badturb = 45;
		}

		$('#effit1').html ( GetTurbName(data.effi[0].turbnum) );
		$('#effit2').html ( GetTurbName(data.effi[1].turbnum) );
		$('#effit3').html ( GetTurbName(data.effi[2].turbnum) );
		$('#effi1').html ( (Math.floor(data.effi[1].value*10000))/100.0+'%' );
		$('#effi2').html ( (Math.floor(data.effi[2].value*10000))/100.0+'%' );
		$('#effi3').html ( (Math.floor(data.effi[3].value*10000))/100.0+'%' );

		var len = data.effi.length;
		$('#effit-1').html ( GetTurbName(data.effi[len-1].turbnum) );
		$('#effit-2').html ( GetTurbName(data.effi[len-2].turbnum) );
		$('#effit-3').html ( GetTurbName(data.effi[len-3].turbnum) );
		$('#effi-1').html ( (Math.floor(data.effi[len-1].value*10000))/100.0+'%' );
		$('#effi-2').html ( (Math.floor(data.effi[len-2].value*10000))/100.0+'%' );
		$('#effi-3').html ( (Math.floor(data.effi[len-3].value*10000))/100.0+'%' );

		DrawPowerReal ( parentreal, canreal, realpower, realwind );
		DrawPowerError ( parenterror, canerror, midpower, badpower, data.badturb );
	});
}

function DrawPowerReal ( parentdiv, canid, data1, data2 ) {

	var can = document.getElementById ( canid );
	var context = can.getContext ( '2d' );

	can.width = 0; 
	can.height = 0;
	can.width = parentdiv.width();
	can.height = parentdiv.height();

	drawBackground ( context, can.width, can.height, 20, 40, 115, 40, 4, 9, 0.1, '#666666' );
	drawYLabel ( context, can.width, can.height, 20, 40, 0, 60, 40, 4, 5, "%.0f", 0.8, lineColorsPowers[0], 0, 100, '功率(MW)' );
	drawYLabel ( context, can.width, can.height, 20, 40, 60, 115, 40, 4, 3, "%.0f", 0.8, lineColorsPowers[1], 0, 20.0, '风速(m/s)' );
	drawXLabel ( context, can.width, can.height, 20, 40, 115, 40, 3, 3, "%.0f", 0.8, '#666666', new Date()-(3600*24*1000), new Date(), '', 1 );

	drawLine ( context, can.width, can.height, 20, 40, 115, 40, 1.8, lineColorsPowers[0], new Date()/1000-(3600*24), new Date()/1000, 0, 100000, data1 );
	drawLine ( context, can.width, can.height, 20, 40, 115, 40, 1.8, lineColorsPowers[1], new Date()/1000-(3600*24), new Date()/1000, 0, 20, data2 );
}

function DrawPowerError ( parentdiv, canid, data1, data2, badid ) {
	var can = document.getElementById ( canid );
	var context = can.getContext ( '2d' );

	can.width = 0; 
	can.height = 0;
	can.width = parentdiv.width();
	can.height = parentdiv.height();

	drawBackground ( context, can.width, can.height, 20, 40, 60, 40, 4, 9, 0.1, '#666666' );
	drawYLabel ( context, can.width, can.height, 20, 40, 0, 60, 40, 4, 5, "%.0f", 0.8, lineColorsPowers[0], 0, 100, '功率(MW)' );
	drawXLabel ( context, can.width, can.height, 20, 40, 60, 40, 3, 3, "%.0f", 0.8, '#666666', new Date()-(3600*24*1000), new Date(), '', 1 );

	drawLine ( context, can.width, can.height, 20, 40, 60, 40, 3, lineColorsPowers[0], new Date()/1000-(3600*24), new Date()/1000, 0, 1500, data1 );
	drawLine ( context, can.width, can.height, 20, 40, 60, 40, 1.8, lineColorsPowers[1], new Date()/1000-(3600*24), new Date()/1000, 0, 1500, data2 );

	context.font = '12px YaHei Consolas Hybrid';
	var lab = GetTurbName ( badid );
	var metrics = context.measureText ( lab );
	context.fillStyle = '#666666';
	context.fillText ( lab, can.width/2 - metrics.width/2, 20 );
}

function DrawPowerCheck ( parentdiv, canid, data ) {
	var can = document.getElementById ( canid );
	var context = can.getContext ( '2d' );

	can.width = 0; 
	can.height = 0;
	can.width = parentdiv.width();
	can.height = parentdiv.height();

	drawBackground ( context, can.width, can.height, 20, 40, 70, 40, 3, 5, 0.1, '#666666' );
	drawYLabel ( context, can.width, can.height, 20, 40, 0, 70, 40, 3, 5, "%.0f", 0.8, lineColorsPowers[0], 0, 1500, '功率(kW)' );
	drawXLabel ( context, can.width, can.height, 20, 40, 70, 40, 5, 5, "%.0f", 0.8, '#666666', 0, 25, '风速(m/s)', 0 );
	drawLine ( context, can.width, can.height, 20, 40, 70, 40, 3, lineColorsPowers[0], 0, 25, 0, 1500, data );
}

function DrawPowerCompare ( parentdiv, canid, data ) {
	var can = document.getElementById ( canid );
	var context = can.getContext ( '2d' );

	can.width = 0; 
	can.height = 0;
	can.width = parentdiv.width();
	can.height = parentdiv.height();


	drawBackground ( context, can.width, can.height, 20, 40, 70, 40, 7, 12, 0.1, '#666666' );
	drawYLabel ( context, can.width, can.height, 20, 40, 0, 70, 40, 3, 5, "%.0f", 0.8, lineColorsCompare[0], 0, 1500, '功率(kW)' );
	drawXLabel ( context, can.width, can.height, 20, 40, 70, 40, 5, 5, "%.0f", 0.8, '#666666', 0, 25, '风速(m/s)', 0 );

	var rowcount = $('#curvelist >tbody >tr').length;
	for ( var i=0; i<rowcount; i++ ) {
		var tr = $('#curvelist >tbody >tr')[i];
		var type = tr.getAttribute('data-type');
		var cs = data[type];

		drawPowerLine ( context, can.width, can.height, 20, 40, 70, 40, 3, lineColorsCompare[i], 
				0, 25, 0, 1500, cs.data );
	}

	if( disptype1 ) {
		drawLine ( context, can.width, can.height, 20, 40, 70, 40, 3, '#000000', 
				0, 25, 0, 1500, stand1 );
	}

	if( disptype2 ) {
		drawLine ( context, can.width, can.height, 20, 40, 70, 40, 3, '#000000', 
				0, 25, 0, 1500, stand2 );
	}
}

function drawPowerLine ( context, width, height, Top, Bottom, Left, Right, LineWidth, LineColor, XMin, XMax, YMin, YMax, Data ) {

	context.save();
	context.beginPath();
	var span = ( width - Left - Right ) / (Data.length-1);
	context.moveTo ( 
					Left + ((Data[0].x-XMin)/(XMax-XMin))*(width-Left-Right),
					Top + (1-(Data[0].y-YMin)/(YMax-YMin))*(height-Top-Bottom) );
	for ( var i=1; i<Data.length; i++ ) {
		if( Data[i].x < 4 || Data[i].y > 0 ) {
		context.lineTo (
						Left + ((Data[i].x-XMin)/(XMax-XMin))*(width-Left-Right),
						Top + (1-(Data[i].y-YMin)/(YMax-YMin))*(height-Top-Bottom) );
		}
	}

	context.lineWidth = LineWidth;
	context.strokeStyle = LineColor;
	context.stroke();

	context.restore();
}

