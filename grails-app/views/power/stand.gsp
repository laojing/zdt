<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>中电投风电场优化系统</title>
	</head>
	<body>

	<div class="mainpage">
	<div class="container">

	<div class="input-group">
	    <span class="input-group-addon glyphicon glyphicon-gift"></span>
		<select class="form-control" id="classes" onchange="ChangeClass();">
		  <option selected value="0">金风机组</option>
		  <option value="1">东汽机组</option>
		</select>
	    <span class="input-group-addon glyphicon glyphicon-gift"></span>
  	</div>
	<div class="seperator"></div>

	<table class="table">
	<tr>
	<th>风速(m/s)</th><th>功率(kW)</th>
	<th>风速(m/s)</th><th>功率(kW)</th>
	</tr>

	<tr>
	<td style="line-height:35px;">3.0</td><td><input id="power1" class="form-control" type="text" value="0.0"></td>
	<td style="line-height:35px;">3.5</td><td><input id="power2" class="form-control" type="text" value="0.0"></td>
	</tr>
	<tr>
	<td style="line-height:35px;">4.0</td><td><input id="power3" class="form-control" type="text" value="0.0"></td>
	<td style="line-height:35px;">4.5</td><td><input id="power4" class="form-control" type="text" value="0.0"></td>
	</tr>
	<tr>
	<td style="line-height:35px;">5.0</td><td><input id="power5" class="form-control" type="text" value="0.0"></td>
	<td style="line-height:35px;">5.5</td><td><input id="power6" class="form-control" type="text" value="0.0"></td>
	</tr>
	<tr>
	<td style="line-height:35px;">6.0</td><td><input id="power7" class="form-control" type="text" value="0.0"></td>
	<td style="line-height:35px;">6.5</td><td><input id="power8" class="form-control" type="text" value="0.0"></td>
	</tr>
	<tr>
	<td style="line-height:35px;">7.0</td><td><input id="power9" class="form-control" type="text" value="0.0"></td>
	<td style="line-height:35px;">7.5</td><td><input id="power10" class="form-control" type="text" value="0.0"></td>
	</tr>
	<tr>
	<td style="line-height:35px;">8.0</td><td><input id="power11" class="form-control" type="text" value="0.0"></td>
	<td style="line-height:35px;">8.5</td><td><input id="power12" class="form-control" type="text" value="0.0"></td>
	</tr>
	<tr>
	<td style="line-height:35px;">9.0</td><td><input id="power13" class="form-control" type="text" value="0.0"></td>
	<td style="line-height:35px;">9.5</td><td><input id="power14" class="form-control" type="text" value="0.0"></td>
	</tr>
	<tr>
	<td style="line-height:35px;">10.0</td><td><input id="power15" class="form-control" type="text" value="0.0"></td>
	<td style="line-height:35px;">10.5</td><td><input id="power16" class="form-control" type="text" value="0.0"></td>
	</tr>
	<tr>
	<td style="line-height:35px;">11.0</td><td><input id="power17" class="form-control" type="text" value="0.0"></td>
	<td style="line-height:35px;">11.5</td><td><input id="power18" class="form-control" type="text" value="0.0"></td>
	</tr>
	<tr>
	<td style="line-height:35px;">12.0</td><td><input id="power19" class="form-control" type="text" value="0.0"></td>
	</tr>

	</table>
	<button type="button" class="btn btn-primary btn-lg btn-block" onclick=SaveData()>保存</button>

	</div>
	</div>


<script>

var url = "${createLink(controller='power',action:'getdefault')}";
var seturl = "${createLink(controller='power',action:'setdefault')}";
function SetDefault ( turbtype ) {
	$.getJSON(url, {turbtype:turbtype}, function(data) {
		for ( var i=0; i<data.defaults.length; i++ ) {
			$('#power'+(i+1)).val(data.defaults[i].power);
		}
	});
}

function ChangeClass() {
	SetDefault ( $('#classes').val() );
}

function SaveData() {
	var sets = '';
	for ( var i=0; i<18; i++ ) {
		sets += $('#power'+(i+1)).val() + "==";
	}
	sets += $('#power19').val();
	$.getJSON(seturl, {turbtype:$('#classes').val(),values:sets}, function(data) {
		for ( var i=0; i<data.defaults.length; i++ ) {
			$('#power'+(i+1)).val(data.defaults[i].power);
		}
	});
}

$(document).ready(function(){
	SetDefault ( 0 );
});

</script>


	</body>
</html>


