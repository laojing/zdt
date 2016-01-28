function drawBackground ( context, width, height, Top, Bottom, Left, Right, YLine, XLine, LineWidth, LineColor ) {

	context.save();
	context.beginPath();

	var yspan = ( height - Top - Bottom ) / YLine;
	for ( var i=0; i<YLine; i++ ) {
		context.moveTo ( Left, Top + yspan*i );
		context.lineTo ( width - Right, Top + yspan*i );
	}

	var xspan = ( width - Left - Right ) / XLine;
	for ( var i=1; i<=XLine; i++ ) {
		context.moveTo ( Left + xspan*i, Top );
		context.lineTo ( Left + xspan*i, height - Bottom );
	}

	context.lineWidth = LineWidth;
	context.strokeStyle = LineColor;
	context.stroke();

	context.restore();
}

function drawXLabel ( context, width, height, Top, Bottom, Left, Right, Line, SmallLine, Format, LineWidth, LineColor, Min, Max, Label, Type ) {

	context.save();
	context.beginPath();
	//context.font = '12px YaHei Consolas Hybrid';
	context.strokeStyle = LineColor;
	context.fillStyle = LineColor;

	context.moveTo ( Left, height - Bottom );
	context.lineTo ( width - Right + 1, height - Bottom );
	var span = ( width - Left - Right ) / Line;
	for ( var i=0; i<=Line; i++ ) {
		context.moveTo ( Left + span*i, height - Bottom );
		context.lineTo ( Left + span*i, height - Bottom + 8 );

		var lab;
		if ( Type == 0 ) {
			lab = (Min + ( Max - Min ) / Line * i).toString();
		} else if ( Type == 1 ) {
			var d = new Date (Min + (Max - Min)/Line*i);
			//lab = d.toLocaleTimeString();
//			lab = d.getHours()+':'+d.getMinutes()+':'+d.getSeconds();
			lab = sprintf ( "%02d:%02d:%02d", d.getHours(), d.getMinutes(), d.getSeconds() );
		}
		var metrics = context.measureText ( lab );
		context.fillText ( lab, Left + span*i - metrics.width/2, height - Bottom + 15 );

		if ( i==Line ) break;
		var insert = span/SmallLine;
		for ( var k=1; k<SmallLine; k++ ) {
			context.moveTo ( Left + i*span + k*insert, height - Bottom  );
			context.lineTo ( Left + i*span + k*insert, height - Bottom + 4 );
		}
	}

	context.fillStyle = LineColor;
	context.fillText ( Label, width/2 - Label.length*4, height - Bottom + 30 );
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

	context.moveTo ( Left, Top - 1 );
	context.lineTo ( Left, height - Bottom );
	var span = ( height - Top - Bottom ) / Line;
	var labelwidth = 0;
	for ( var i=0; i<=Line; i++ ) {

		context.moveTo ( Left - 8, Top + span*i );
		context.lineTo ( Left, Top + span*i );

		var lab = sprintf ( Format, (Max - ( Max - Min ) / Line * i) );
		context.fillText ( lab, Left - 8 - lab.length*8, Top + span*i + 3 );
		if ( lab.length*8 > labelwidth ) labelwidth = lab.length*8;

		if ( i==Line ) break;
		var insert = span/SmallLine;
		for ( var k=1; k<SmallLine; k++ ) {
			context.moveTo ( Left-4, Top + i*span + k*insert  );
			context.lineTo ( Left, Top + i*span + k*insert );
		}
	}

	context.save();
	//context.translate ( Left0 + 25, Top + ( height - Top - Bottom )/2 + Label.length*4 );
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

function drawPoints ( context, width, height, Top, Bottom, Left, Right, LineWidth, LineColor, XMin, XMax, YMin, YMax, Data ) {

	context.save();
	context.beginPath();
	var span = ( width - Left - Right ) / (Data.length-1);
	context.moveTo ( 
					Left + ((Data[0].x-XMin)/(XMax-XMin))*(width-Left-Right),
					Top + (1-(Data[0].y-YMin)/(YMax-YMin))*(height-Top-Bottom) );
	context.arc ( Left + ((Data[0].x-XMin)/(XMax-XMin))*(width-Left-Right),
					Top + (1-(Data[0].y-YMin)/(YMax-YMin))*(height-Top-Bottom),
					LineWidth, 0, Math.PI*2, true);
	for ( var i=1; i<Data.length; i+=1 ) {
		context.moveTo (
						Left + ((Data[i].x-XMin)/(XMax-XMin))*(width-Left-Right),
						Top + (1-(Data[i].y-YMin)/(YMax-YMin))*(height-Top-Bottom) );
		context.arc ( Left + ((Data[i].x-XMin)/(XMax-XMin))*(width-Left-Right),
						Top + (1-(Data[i].y-YMin)/(YMax-YMin))*(height-Top-Bottom),
						LineWidth, 0, Math.PI*2, true);
	}

	context.lineWidth = LineWidth;
	context.strokeStyle = LineColor;
	context.stroke();

	context.restore();
}

