<!doctype html>
<html>
    <head> <meta name="layout" content="main"/> </head>

    <body>

	<div class="mainpage">
    <div class="container">
	<div id="powererror" class="panel">
	    <div class="panel-heading">偏航总览</div>
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
				document.write ( '			<tr> <td>风&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;向:</td> <td id="kk1'+(i*8+j)+'" style="min-width: 30px;">---</td> </tr>' );
				document.write ( '			<tr> <td>机舱位置:</td> <td id="kk2'+(i*8+j)+'" style="min-width: 30px;">---</td> </tr>' );
				document.write ( '			<tr> <td>偏航误差:</td> <td style="min-width: 30px;margin: 5px;color:white;background-color: green;" id="kk3'+(i*8+j)+'">---</td> </tr>' );
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
				document.write ( '			<tr> <td>风&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;向:</td> <td id="kk1'+(i*8+j)+'" style="min-width: 30px;">---</td> </tr>' );
				document.write ( '			<tr> <td>机舱位置:</td> <td id="kk2'+(i*8+j)+'" style="min-width: 30px;">---</td> </tr>' );
				document.write ( '			<tr> <td>偏航误差:</td> <td style="min-width: 30px;margin: 5px;color:white;background-color: green;" id="kk3'+(i*8+j)+'">---</td> </tr>' );
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

var windurl = "${createLink(controller='pitch',action:'getwinddata')}";

var hhh;
function UpdateYawData() {
	$.getJSON(windurl, function(data) {
		hhh = data.tens;
		var turb = $('#turbinetype').val();
		if ( turb == 1 ) {
			for ( var i=1; i<34; i++ ) {
				$('#kk1'+i).html( (data.tens[i].position - data.tens[i].direct).toFixed(2) + '°' );
				$('#kk2'+i).html( data.tens[i].position.toFixed(2) + '°' );
				$('#kk3'+i).html( data.tens[i].direct.toFixed(2) + '°' );
			}
		} else {
			for ( var i=1; i<26; i++ ) {
				$('#kk1'+(i)).html( (data.tens[i+33].position - data.tens[i+33].direct).toFixed(2) + '°' );
				$('#kk2'+(i)).html( data.tens[(i+33)].position.toFixed(2) + '°' );
				$('#kk3'+(i)).html( data.tens[(i+33)].direct.toFixed(2) + '°' );
			}
			for ( var i=26; i<32; i++ ) {
				$('#kk1'+(i)).html( (data.tens[i+35].position - data.tens[i+33].direct).toFixed(2) + '°' );
				$('#kk2'+(i)).html( data.tens[(i+35)].position.toFixed(2) + '°' );
				$('#kk3'+(i)).html( data.tens[(i+35)].direct.toFixed(2) + '°' );
			}
		}
	});
}
function UpdateOver() {
	UpdateYawData();
	window.setTimeout ( UpdateOver, UPDATESPAN );
}

$(document).ready(function(){
	TurbTypeChange();
});


function TurbTypeChange () {
	if ( $('#turbinetype').val() == 2 ) {
		$('#turbine33').hide();
		$('#turbine32').hide();
		for ( var i=1; i<26; i++ ) {
			$('#turbinetitle'+i).html('东气'+i+'号');
		}
		for ( var i=26; i<32; i++ ) {
			$('#turbinetitle'+i).html('东气'+(i+2)+'号');
		}
	} else {
		$('#turbine32').show();
		$('#turbine33').show();
		for ( var i=1; i<34; i++ ) {
			$('#turbinetitle'+i).html('金风'+i+'号');
		}
	}
	UpdateYawData();
}
</script>


    </body>
</html>
