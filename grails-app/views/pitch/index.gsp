<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>中电投风电场优化系统</title>
	</head>
	<body>

	<div class="mainpage">
	<div class="container">
	<div id="powererror" class="panel">
	    <div class="panel-heading">转矩控制优化</div>
	</div>

<script>
	for ( var i=0; i<5; i++ ) {
		document.write ( '<div class="row" style="margin-top:10px;">' );

        document.write ( '<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div class="row">' );
		for ( var j=0; j<4; j++ ) {
			if ( i < 4 || j < 2 ) { 
			if ( i==0 && j==0 ) {
				document.write ( '<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">' );
				document.write ( '	<div class="form-inline">' );
				document.write ( '		<div class="form-group">' );
				document.write ( '			<div class="input-group">' );
				document.write ( '				<div class="input-group-addon">机型：</div>' );
				document.write ( '				<select id="turbinetype" onchange="TurbTypeChange();" name="windField" class="form-control">' );
				document.write ( '					<option id="001" value="001">金风机组</option>' );
				document.write ( '					<option id="002" value="002">东汽机组</option>' );
				document.write ( '				</select>' );
				document.write ( '			</div>' );
				document.write ( '		</div>' );
				document.write ( '	</div>' );
				document.write ( '</div>' );
			} else {
				document.write ( '<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3" id="turbine'+(i*8+j)+'">' );
				document.write ( '	<div class="panel panel-default">' );
				document.write ( '		<div class="panel-heading">' );
				document.write ( '			<table> <tr> <td> <span class="glyphicon glyphicon-fire"></span> </td>' );
				document.write ( '			<td> <h3 id="turbinetitle'+(i*8+j)+'" class="panel-title">'+(i*8+j)+'号机组</h3><!--机组号--> </td> </tr> </table>' );
				document.write ( '		</div>' );
				document.write ( '		<table class="itemtable">' );
			document.write ( '			<tr> <td>转矩系数：</td> <td id="kk1'+(i*8+j)+'" style="min-width: 30px;">---</td> </tr>' );
			document.write ( '			<tr> <td>有功功率：</td> <td id="kk2'+(i*8+j)+'" style="min-width: 30px;">---</td> </tr>' );
			document.write ( '			<tr> <td>电机转速：</td> <td id="kk3'+(i*8+j)+'" style="min-width: 30px;margin: 5px;color:white;background-color: green;">---</td> </tr>' );
				document.write ( '		</table>' );
				document.write ( '	</div>' );
				document.write ( '</div>' );
			}
			}
		}
		document.write ( '</div></div>' );

        document.write ( '<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div class="row">' );
		for ( var j=4; j<8; j++ ) {
			if ( i < 4 ) { 
				document.write ( '<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3" id="turbine'+(i*8+j)+'">' );
			document.write ( '	<div class="panel panel-default">' );
			document.write ( '		<div class="panel-heading">' );
			document.write ( '			<table> <tr> <td> <span class="glyphicon glyphicon-fire"></span> </td>' );
				document.write ( '			<td> <h3 id="turbinetitle'+(i*8+j)+'" class="panel-title">'+(i*8+j)+'号机组</h3><!--机组号--> </td> </tr> </table>' );
			document.write ( '		</div>' );
			document.write ( '		<table class="itemtable">' );
			document.write ( '			<tr> <td>转矩系数：</td> <td id="kk1'+(i*8+j)+'" style="min-width: 30px;">---</td> </tr>' );
			document.write ( '			<tr> <td>有功功率：</td> <td id="kk2'+(i*8+j)+'" style="min-width: 30px;">---</td> </tr>' );
			document.write ( '			<tr> <td>电机转速：</td> <td id="kk3'+(i*8+j)+'" style="min-width: 30px;margin: 5px;color:white;background-color: green;">---</td> </tr>' );
			document.write ( '		</table>' );
			document.write ( '	</div>' );
			document.write ( '</div>' );
			}
		}
		document.write ( '</div></div>' );
		document.write ( '</div>' );
	}
</script>

	</div>
	</div>

<script>

var pitchurl = "${createLink(controller='pitch',action:'getpitchdata')}";

var alarm = 0;
function UpdateData() {
	$.getJSON(pitchurl, function(data) {
		var turb = $('#turbinetype').val();
		if ( alarm == 0 && data.tens.length == 0 ) {
			alarm = 1;
			alert ( '数据库更新错误！所有数值只是页面展示作用！' );
		}
		if ( data.tens.length == 0 ) {
			for ( var i=0; i<67; i++ ) {
				data.gains[i] = {optgain:0.4-i};
				data.tens[i] = {speed:1500+(i*5),power:800+(i*10)};
			}
		}

		if ( turb == 1 ) {
			for ( var i=1; i<34; i++ ) {
				$('#kk1'+i).html( data.gains[i-1].optgain );
				$('#kk2'+i).html( data.tens[i].power );
				$('#kk3'+i).html( data.tens[i].speed );
			}
		} else {
			for ( var i=1; i<26; i++ ) {
				$('#kk1'+(i)).html( data.gains[(i+32)].optgain );
				$('#kk2'+(i)).html( data.tens[(i+33)].power );
				$('#kk3'+(i)).html( data.tens[(i+33)].speed );
			}
			for ( var i=26; i<32; i++ ) {
				$('#kk1'+(i)).html( data.gains[(i+34)].optgain );
				$('#kk2'+(i)).html( data.tens[(i+35)].power );
				$('#kk3'+(i)).html( data.tens[(i+35)].speed );
			}
		}
	});
}

function UpdateOver() {
	UpdateData();
	window.setTimeout ( UpdateOver, UPDATESPAN );
}

$(document).ready(function(){
	UpdateOver();
});

function TurbTypeChange () {
	if ( $('#turbinetype').val() == 2 ) {
		$('#turbine33').hide();
		$('#turbine32').hide();
		for ( var i=1; i<26; i++ ) {
			$('#turbinetitle'+i).html(i+'号机组');
		}
		for ( var i=26; i<32; i++ ) {
			$('#turbinetitle'+i).html((i+2)+'号机组');
		}
	} else {
		$('#turbine32').show();
		$('#turbine33').show();
		for ( var i=1; i<34; i++ ) {
			$('#turbinetitle'+i).html(i+'号机组');
		}
	}
	UpdateData();
}

</script>
	</body>
</html>
