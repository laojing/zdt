var alarm = 0;
var ttt = 1;
function UpdateOverFarm () {
	$.getJSON(GetHref('updateover','index'), function(data) {
		if ( alarm == 0 && data.real.length == 0 ) {
			alarm = 1;
//			alert ( '数据库更新错误！所有数值只是页面展示作用！' );
		}
		if ( data.real.length == 0 ) {
			$('#connectstate').html ( '数据库更新错误！所有数值只是页面展示作用！' );
		} else {
			$('#connectstate').html ( '数据库更新正常' );
		}
		ttt = data.follow;

		var effilen1 = data.effi1.length;
		var effilen2 = data.effi2.length;
		var pitchlen1 = data.pitch1.length;
		var pitchlen2 = data.pitch2.length;
		var windlen1 = data.wind1.length;
		var windlen2 = data.wind2.length;
		for( var i=0; i<3; i++ ) {
			if ( effilen1 < 3 ) {
				$('#effit-'+(i+1)).html(i+6+'号机组');
				$('#effi-'+(i+1)).html(-(i+1)*4+'%');
			} else {
				$('#effit-'+(i+1)).html(data.effi1[effilen1-1-i].turbnum+'号机组');
				$('#effi-'+(i+1)).html((Math.floor(data.effi1[effilen1-1-i].value*10000))/100.0+'%');
			}
			if ( effilen1 < 3 ) {
				$('#effit2-'+(i+1)).html(i+36+'号机组');
				$('#effi2-'+(i+1)).html(-(i+8)*3+'%');
			} else {
				$('#effit2-'+(i+1)).html(data.effi2[effilen2-1-i].turbnum+'号机组');
				$('#effi2-'+(i+1)).html((Math.floor(data.effi2[effilen2-1-i].value*10000))/100.0+'%');
			}

			if ( pitchlen1 > 0 ) {
				$('#pitcht-'+(i+1)).html(data.pitch1[pitchlen1-1-i].turbnum+'号机组');
				$('#pitch-'+(i+1)).html(data.pitch1[pitchlen1-1-i].optgain);
			} else {
				$('#pitcht-'+(i+1)).html(i+2+'号机组');
				$('#pitch-'+(i+1)).html(1450+i*3);
			}
			if ( pitchlen2 > 0 ) {
				$('#pitcht2-'+(i+1)).html(data.pitch2[pitchlen2-1-i].turbnum+'号机组');
				$('#pitch2-'+(i+1)).html(data.pitch2[pitchlen1-1-i].optgain);
			} else {
				$('#pitcht2-'+(i+1)).html(i+42+'号机组');
				$('#pitch2-'+(i+1)).html(0.00013 + i*0.0004);
			}
			if ( windlen1 > 0 ) {
				$('#windt-'+(i+1)).html(data.wind1[windlen1-1-i].turbnum+'号机组');
				$('#wind-'+(i+1)).html(data.wind1[windlen1-1-i].alpha);
			} else {
				$('#windt-'+(i+1)).html(i+3+'号机组');
				$('#wind-'+(i+1)).html(0.7);
			}
			if ( windlen2 > 0 ) {
				$('#windt2-'+(i+1)).html(data.wind2[windlen2-1-i].turbnum+'号机组');
				$('#wind2-'+(i+1)).html(data.wind2[windlen1-1-i].alpha);
			} else {
				$('#windt2-'+(i+1)).html(i+43+'号机组');
				$('#wind2-'+(i+1)).html(0.6);
			}
		}
		if ( data.real.length > 0 ) {
			$('#totalwind').html(parseFloat(data.real[0].wind).toFixed(2)+' m/s');
			$('#totalpower').html((parseFloat(data.real[0].power)/1000).toFixed(2)+' MW');
		} else {
			$('#totalwind').html(10.3 +' m/s');
			$('#totalpower').html(34.5 +' MW');
		}

		if ( data.follow.length > 0 ) {
			for( var i=0; i<data.follow.length; i++ ) {
				// 机组无功输出优化前
				if( data.follow[i].turbnum == 104 ) {
					$('#follow-1').html( parseInt(data.follow[i].value) + 'kVar' );
				// 机组无功输出优化后
				} else if( data.follow[i].turbnum == 103 ) {
					$('#follow2-1').html( parseInt(data.follow[i].value) + 'kVar' );
				// 风电场无功输出优化前
				} else if( data.follow[i].turbnum == 105 ) {
					$('#follow-2').html( parseInt(data.follow[i].value) + 'kVar' );
				// 风电场无功输出优化后
				} else if( data.follow[i].turbnum == 102 ) {
					$('#follow2-2').html( parseInt(data.follow[i].value) + 'kVar' );
				} else if( data.follow[i].turbnum == 100 ) {
					$('#follow-3').html( parseInt(data.follow[i].value) + 'kVar' );
				} else if( data.follow[i].turbnum == 101 ) {
					$('#follow2-3').html( parseInt(data.follow[i].value) + 'kVar' );
				}
			}
		}

		DrawOverFarm( data.real );
	});
}

function DrawTurbGround ( context, power, value, x, y, index ) {
	context.drawImage ( turbimg, x-30, y-30 );
	var path = new Path2D();
	path.arc ( x, y, 15, 0, Math.PI*2 );
	context.fillStyle = 'rgba(100,100,100,0.9)';
	if ( value > 33 ) context.fillStyle = 'rgba(50,50,100,0.9)';
	context.fill( path );

	var lab = sprintf ( "%02d", value );
	var metrics = context.measureText ( lab );
	context.fillStyle = 'rgba(250,250,250,1)';
	context.fillText ( lab, x-metrics.width/2, y-5 );
	lab = sprintf ( "%04d", power );
	metrics = context.measureText ( lab );
//	context.fillStyle = 'rgba(250,50,50,1)';
	context.fillText ( lab, x-metrics.width/2, y+8 );
}

function DrawOverFarm ( data ) {
	var can = document.getElementById ( "canover" );
	var context = can.getContext ( '2d' );
	var width = can.width;
	var height = can.height;
	can.width = 0; can.height = 0;
	can.width = width; can.height = height;
	
	context.save();

	for ( var i=0; i<turbpos.length; i++ ) {
		var x = width*(turbpos[i].x - minx)/(maxx - minx);
		var y = height - height*(turbpos[i].y - miny)/(maxy - miny);
		if ( data.length >i ) {
		DrawTurbGround ( context, 
				data[i+1].power,
				turbpos[i].v, x, y, i );
		} else {
		DrawTurbGround ( context, 
				800+i*5,
				turbpos[i].v, x, y, i );
		}
	}

	context.restore();
}
