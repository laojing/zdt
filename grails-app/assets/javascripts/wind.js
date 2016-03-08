var isover = false;

var minx = 5000;
var maxx = 0;
var miny = 5000;
var maxy = 0;
var turbsize = 50;
var turbimg = new Image();
var turbimgred = new Image();

function InitPos() {
	for ( var i=0; i<turbpos.length; i++ ) {
		if ( minx > turbpos[i].x ) minx = turbpos[i].x;
		if ( maxx < turbpos[i].x ) maxx = turbpos[i].x;
		if ( miny > turbpos[i].y ) miny = turbpos[i].y;
		if ( maxy < turbpos[i].y ) maxy = turbpos[i].y;
	}
	minx -= 3*turbsize;
	miny -= 2*turbsize;
	maxx += 4*turbsize;
	maxy += 4*turbsize;
	turbimg.src = turbpic;
	turbimgred.src = turbpicred;
}

var dirrose = ['东','东南','南','西南', '西','西北','北','东北'];

function drawText ( context, value, rad, radius, x, y, span ) {
	context.save();
	var len = context.measureText(value.toString());
	var x1 = (radius) * Math.cos(rad);
	var y1 = (radius) * Math.sin(rad);
	context.translate ( x, y );
	context.rotate ( rad + Math.PI/2 );
	context.fillText ( value.toString(), -len.width/2, -span-radius );
	context.restore();
}

function drawLine ( context, rad, radius1, radius2, x, y ) {
	var x1 = x + radius1 * Math.cos(rad);
	var y1 = y + radius1 * Math.sin(rad);
	var x2 = x + radius2 * Math.cos(rad);
	var y2 = y + radius2 * Math.sin(rad);
	context.moveTo ( x1, y1 );
	context.lineTo ( x2, y2 );
}

function UpdateWindPic( over ) {
	$.getJSON(windurl, function(data) {
		var total = 0;
		for ( var i=1; i<data.total.length; i++ ) {
			/*
			while ( data.total[i].position>360 ) data.total[i].position-=360;
			while ( data.total[i].position<-360 ) data.total[i].position+=360;
			*/
			total += data.total[i].position;
		}
		DrawWindPic ( over, total/66, data.total );
	});
}

function DrawTurbGround ( context, turbimg, pos, dir, value, x, y, index ) {
	var direrror = dir*Math.PI/180;

	context.drawImage ( turbimg, x-30, y-30 );

	var path = new Path2D();
	path.arc ( x, y, 15, 0, Math.PI*2 );
	context.fillStyle = 'rgba(100,100,100,0.3)';
	if ( value > 33 ) context.fillStyle = 'rgba(0,0,100,0.5)';
	context.fill( path );

	var lab = sprintf ( "%d", value );
	if ( index == 100 ) lab = "风机号";
	var metrics = context.measureText ( lab );
	context.fillStyle = 'rgba(100,100,100,0.9)';
	context.fillText ( lab, x-8-metrics.width, y-12 );
	lab = sprintf ( "%d°", direrror*180/Math.PI );
	if ( index == 100 ) lab = "偏航误差";
	context.fillText ( lab, x+10, y-12 );

	context.beginPath(); 
	var r = pos*Math.PI/180-Math.PI/2; 
	drawLine ( context, r, 20, 0, x, y );
	context.closePath(); 
	context.strokeStyle = "#666";
	context.stroke();

	path = new Path2D();
	path.moveTo ( x, y );
	if ( direrror < 0 ) {
		path.arc ( x, y, 15, pos*Math.PI/180-Math.PI/2, 
				pos*Math.PI/180-Math.PI/2 + direrror, true );
	} else {
		path.arc ( x, y, 15, pos*Math.PI/180-Math.PI/2, 
				pos*Math.PI/180-Math.PI/2 + direrror, false );
	}
	context.fillStyle = 'rgba(200,0,0,0.8)';
	context.fill( path );
}


function DrawWindPic ( over, overdir, total ) {

	var can = document.getElementById ( "windpic" );
	var context = can.getContext ( '2d' );

	var width = can.width;
	var height = can.height;
	can.width = 0;
	can.height = 0;
	can.width = width;
	can.height = height;
	
	context.save();

	var mWidth = 250;
	var mHeight = 250;
	var radius = mHeight/2;
	if ( mWidth < mHeight ) radius = mWidth/2;
	radius -= 50;
	context.beginPath(); 
	context.strokeStyle = "#ddd";
	context.fillStyle = "#666"; 
	context.arc(mWidth/2, mHeight/2, radius, 0, Math.PI*2, true); 
	context.arc(mWidth/2, mHeight/2, radius*2/5, 0, Math.PI*2, true); 
	context.arc(mWidth/2, mHeight/2, radius*4/5, 0, Math.PI*2, true); 
	context.closePath(); 
	context.strokeStyle = "#ddd";
	context.stroke();
	context.font = "10px 'LiHei Pro'";
	for ( var i=0; i<8; i++ ) {
		context.beginPath(); 
		context.fillStyle = "#666"; 
		var r = i*(Math.PI*2)/8;
		drawLine ( context, r, radius, 10, mWidth/2, mHeight/2 );
		drawText ( context, dirrose[i], r, radius, mWidth/2, mHeight/2, 8 );
		context.closePath(); 
		context.stroke();
		context.strokeStyle = "#ddd";
	}

	// 左上角方向
	for( var j=0; j<total.length; j++ ) {
		var path = new Path2D();
		var rad = (total[j].position + total[j].direct)*Math.PI/180;
		var x1 = mWidth/2 + radius * Math.cos(rad - Math.PI/2);
		var y1 = mHeight/2 + radius * Math.sin(rad - Math.PI/2);
		path.arc ( x1, y1, 2, 0, Math.PI*2 );
		context.fillStyle = "#a00";
		context.fill( path );
	}
	/*
	var path = new Path2D();
	var rad = overdir*Math.PI/180;
	var x1 = mWidth/2 + radius * Math.cos(rad - Math.PI/2);
	var y1 = mHeight/2 + radius * Math.sin(rad - Math.PI/2);
	path.arc ( x1, y1, 4, 0, Math.PI*2 );
	context.fillStyle = "#a00";
	context.fill( path );
	context.font = "12px serif";
	var lab = sprintf ( "%03d°", rad*180/Math.PI );
	context.fillText ( lab, mWidth/2-10, mHeight/2+5 );
	*/




	context.font = "12px serif";
	for ( var i=0; i<turbpos.length; i++ ) {
		if ( ( disptype1 && i<33 ) 
			|| ( disptype2 && i>=33 ) ) {
			var x = width*(turbpos[i].x - minx)/(maxx - minx);
			var y = height - height*(turbpos[i].y - miny)/(maxy - miny);
			if ( total.length > i ) {
				var curturb = 0;
				for( var j=0; j<total.length; j++ ) {
					if( total[j].turbnum == turbpos[i].v ) {
						curturb = j; break;
					}
				}
				DrawTurbGround ( context, turbimg, 
						total[curturb].position, 
						total[curturb].direct,
						turbpos[i].v, x, y, i );
			} else {
			DrawTurbGround ( context, turbimg, 
					45, 
					60,
					turbpos[i].v, x, y, i );
			}
		}
	}

	DrawTurbGround ( context, turbimg, 60, 40, 1, width-150, 30, 100  );
	DrawTurbGround ( context, turbimg, 60, 40, 34, width-150, 80, 34 );

	context.fillStyle = "#666";
	context.fillText ( "金风机组", width-100, 35 );
	context.fillText ( "东汽机组", width-100, 85 );
	context.restore();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
function UpdateSectorPic( over ) {
	$.getJSON(sectorurl, function(data) {
		var total = 0;
		for ( var i=1; i<data.total.length; i++ ) {
			total += data.total[i].position;
		}
		DrawSectorPic ( over, total/66, data.total );
	});
}

function DrawSectorPic ( over, overdir, total ) {

	var can = document.getElementById ( "windpic" );
	var context = can.getContext ( '2d' );

	var width = can.width;
	var height = can.height;
	can.width = 0;
	can.height = 0;
	can.width = width;
	can.height = height;
	
	context.save();

	var mWidth = 250;
	var mHeight = 250;
	var radius = mHeight/2;
	if ( mWidth < mHeight ) radius = mWidth/2;
	radius -= 50;
	context.beginPath(); 
	context.strokeStyle = "#ddd";
	context.fillStyle = "#666"; 
	context.arc(mWidth/2, mHeight/2, radius, 0, Math.PI*2, true); 
	context.arc(mWidth/2, mHeight/2, radius*2/5, 0, Math.PI*2, true); 
	context.arc(mWidth/2, mHeight/2, radius*4/5, 0, Math.PI*2, true); 
	context.closePath(); 
	context.strokeStyle = "#ddd";
	context.stroke();
	context.font = "10px 'LiHei Pro'";

	for ( var i=0; i<16; i++ ) {
		context.beginPath(); 
		context.fillStyle = "#666"; 
		var r = i*(Math.PI*2)/16;
		drawLine ( context, r, radius, 10, mWidth/2, mHeight/2 );
		if ( i % 2 == 0 )
		drawText ( context, dirrose[i/2], r, radius, mWidth/2, mHeight/2, 8 );
		context.closePath(); 
		context.stroke();
		context.strokeStyle = "#ddd";
	}

	var path = new Path2D();
	var rad = overdir*Math.PI/180;
	var x1 = mWidth/2 + radius * Math.cos(rad - Math.PI/2);
	var y1 = mHeight/2 + radius * Math.sin(rad - Math.PI/2);
	path.arc ( x1, y1, 4, 0, Math.PI*2 );
	context.fillStyle = "#a00";
	context.fill( path );
	context.font = "12px serif";
	var lab = sprintf ( "%03d°", rad*180/Math.PI );
	context.fillText ( lab, mWidth/2-10, mHeight/2+5 );

	context.font = "12px serif";
	for ( var i=0; i<turbpos.length; i++ ) {
		var x = width*(turbpos[i].x - minx)/(maxx - minx);
		var y = height - height*(turbpos[i].y - miny)/(maxy - miny);
		DrawTurbSector ( context, turbimg, 
				total[i].position, 
				total[i].direct,
				turbpos[i].v, x, y, i );
	}

	context.restore();
}

function DrawTurbSector ( context, turbimg, pos, dir, value, x, y, index ) {
	if ( value == 5 
			|| value == 7
			|| value == 6 ) {
		context.drawImage ( turbimgred, x-15, y-10 );

		var lab = sprintf ( "%d", value );
		var metrics = context.measureText ( lab );
		context.fillStyle = 'rgba(100,100,100,0.9)';
		context.fillText ( lab, x-metrics.width/2, y-12 );
	} else {
		context.drawImage ( turbimg, x-10, y-10 );
	}
}


