function drawBackground ( context, width, height, Top, Bottom, Left, Right, YLine, XLine, LineWidth, LineColor ) {

	context.save();
	context.beginPath();

	var yspan = ( height - Top - Bottom ) / YLine;
	for ( var i=0; i<YLine; i++ ) {
		context.moveTo ( Left, Top + yspan*i );
		context.lineTo ( width - Right, Top + yspan*i );
	}

	context.lineWidth = LineWidth;
	context.strokeStyle = LineColor;
	context.stroke();

	context.restore();
}

function drawXLabel ( context, width, height, Top, Bottom, Left, Right, Line, SmallLine, Format, LineWidth, LineColor, data, Label, Min, Max, Type ) {

	context.save();
	context.beginPath();
	//context.font = '12px YaHei Consolas Hybrid';
	context.strokeStyle = LineColor;
	context.fillStyle = LineColor;

	Line = data.length;
	var cur = new Date();
	context.moveTo ( Left, height - Bottom );
	context.lineTo ( width - Right + 1, height - Bottom );
	var span = ( width - Left - Right ) / Line;
	for ( var i=0; i<=Line; i++ ) {
		context.moveTo ( Left + span*i, height - Bottom );
		context.lineTo ( Left + span*i, height - Bottom + 8 );
		context.stroke();

		if( i==Line ) break;
		cur.setTime( data[i].savetime*1000 );
		var lab = cur.toLocaleDateString();
		var metrics = context.measureText ( lab );

		context.save();
		var metrics = context.measureText ( Label );
		context.translate ( Left + span*(i+0.3), height - Bottom + 50 );
		context.rotate ( -Math.PI/4 );
		context.fillStyle = LineColor;
		context.fillText ( lab, 0, 0 );
		context.restore();

		var valuelen = (data[i].optgain-Min)/(Max-Min)*(height - Top - Bottom);
		lab = sprintf ( "%4.2f", data[i].optgain );
		if( varturbinenum > 33 ) {
			valuelen = (data[i].optgain-Min)/(Max-Min)*(height - Top - Bottom);
			lab = sprintf ( "%.6f", data[i].optgain );
		}

		/*
		context.fillStyle = '#8080a8';
		context.fillRect( Left + span*(i+0.3), 
						height-Bottom-valuelen,
						span*0.4, valuelen );
						*/

		var metrics = context.measureText ( lab );
		context.fillText ( lab, Left + span*(i+0.5) - metrics.width/2, 
				height - Bottom - valuelen - 13 );
	}
	context.stroke();

	for ( var i=0; i<=Line; i++ ) {
		if( i==Line ) break;

		var valuelen = (data[i].optgain-Min)/(Max-Min)*(height - Top - Bottom);
		if( varturbinenum > 33 ) {
			valuelen = (data[i].optgain-Min)/(Max-Min)*(height - Top - Bottom);
		}
		if ( i==0 ) {
			context.moveTo( Left + span*(i+0.3) + span*0.2, 
						height-Bottom-valuelen );
		} else {
			context.lineTo( Left + span*(i+0.3) + span*0.2, 
						height-Bottom-valuelen );
		}
	}

	context.lineWidth = LineWidth;
	context.strokeStyle = LineColor;
	context.stroke();

	context.restore();
}

function drawYLabel ( context, width, height, Top, Bottom, Left0, Left, Right, Line, SmallLine, Format, LineWidth, LineColor, Min, Max, Label ) {

	context.save();
	context.beginPath();
	//context.font = '12px';
	context.fillStyle = LineColor;
	context.strokeStyle = LineColor;

	var span = ( height - Top - Bottom ) / Line;
	var labelwidth = 0;
	for ( var i=0; i<=Line; i++ ) {
		var lab = sprintf ( Format, (Max - ( Max - Min ) / Line * i) );
		var metrics = context.measureText ( lab );
		context.fillText ( lab, Left - metrics.width - 3, Top + span*i + 3 );
	}

	context.save();
	var metrics = context.measureText ( Label );
	context.translate ( Left0 + 25, Top + ( height - Top - Bottom )/2 + metrics.width/2 );
	context.rotate ( -Math.PI/2 );
	context.fillStyle = LineColor;
	context.fillText ( Label, 0, 0 );
	context.restore();

	context.lineWidth = LineWidth;
	context.strokeStyle = LineColor;
	context.stroke();

	context.restore();
}

function drawLine ( context, width, height, Top, Bottom, Left, Right, LineWidth, LineColor, XMin, XMax, YMin, YMax, Data ) {

	context.save();
	context.beginPath();
	var span = ( width - Left - Right ) / (Data.length-1);
	context.moveTo ( 
					Left + ((Data[0].x-XMin)/(XMax-XMin))*(width-Left-Right),
					Top + (1-(Data[0].y-YMin)/(YMax-YMin))*(height-Top-Bottom) );
	for ( var i=1; i<Data.length; i++ ) {
		context.lineTo (
						Left + ((Data[i].x-XMin)/(XMax-XMin))*(width-Left-Right),
						Top + (1-(Data[i].y-YMin)/(YMax-YMin))*(height-Top-Bottom) );
	}

	context.lineWidth = LineWidth;
	context.strokeStyle = LineColor;
	context.stroke();

	context.restore();
}


function drawXLabel2 ( context, width, height, Top, Bottom, Left, Right, Line, SmallLine, Format, LineWidth, LineColor, data, Label, Type ) {

	context.save();
	context.beginPath();
	//context.font = '12px YaHei Consolas Hybrid';
	context.strokeStyle = LineColor;
	context.fillStyle = LineColor;

	Line = data.length;
	var cur = new Date();
	context.moveTo ( Left, height - Bottom );
	context.lineTo ( width - Right + 1, height - Bottom );
	var span = ( width - Left - Right ) / Line;
	for ( var i=0; i<=Line; i++ ) {
		context.moveTo ( Left + span*i, height - Bottom );
		context.lineTo ( Left + span*i, height - Bottom + 8 );
		context.stroke();

		if( i==Line ) break;
		context.save();

		cur.setTime( data[i].savetime*1000 );
		var lab = sprintf ( "%d号机组", i+1 );
		var metrics = context.measureText ( lab );
		context.translate ( Left+span*(i+0.5)+3, height-Bottom+metrics.width+5 );
		context.rotate ( -Math.PI/2 );
		context.fillStyle = LineColor;
		context.fillText ( lab, 0, 0 );
		context.restore();

		var valuelen = data[i].optgain/1600*(height - Top - Bottom);
		if( varturbinetype == 2 ) {
			valuelen = data[i].optgain/0.002*(height - Top - Bottom);
		}

		context.fillStyle = '#8080a8';
		context.fillRect( Left + span*(i+0.3), 
						height-Bottom-valuelen,
						span*0.4, valuelen );


		lab = sprintf ( "%4.2f", data[i].optgain );
		if( varturbinetype == 2 ) {
			valuelen = data[i].optgain/0.002*(height - Top - Bottom);
			lab = sprintf ( "%.6f", data[i].optgain );
		}
		metrics = context.measureText ( lab );
		context.save();
		if( metrics.width + 10 < valuelen ) {
			context.translate ( Left+span*(i+0.5)+3, height-Bottom-valuelen+metrics.width+5 );
			context.fillStyle = '#ffffff';
		} else {
			context.translate ( Left+span*(i+0.5)+3, height-Bottom-valuelen-5 );
		}
		context.rotate ( -Math.PI/2 );
		context.fillText ( lab, 0, 0 );
		context.restore();
	}

	context.lineWidth = LineWidth;
	context.strokeStyle = LineColor;
	context.stroke();

	context.restore();
}

