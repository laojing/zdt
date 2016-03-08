<!doctype html>
<html>
    <head> <meta name="layout" content="main"/> </head>
    <body>
	<asset:javascript src="turbpos.js"/>
	<asset:javascript src="over.js"/>

	<div class="mainpage">

<div style="position:absolute;left:20px;bottom:20px;color:#666;font-size:14px;font-weight:bold;">
<span id="connectstate" style="color:#222;"></span>
</div>


<div style="position:absolute;left:320px;top:80px;width:280px;color:#666;font-size:16px;font-weight:bold;">
V:<span id="totalwind" style="color:#222;"></span>
<br/>
P:<span id="totalpower" style="color:#222;"></span>
</div>
<div style="position:absolute;left:20px;top:70px;width:280px;" class="panel panel-primary">
<div class="panel-heading"><script>document.write(OptNames[0][0][0]);</script></div>
	<table id="effi" class="suttable" style="margin:5px 2%;height:100px;width:96%;">
	<tr>
		<th colspan="2" style="text-align:center;">金风后三名</th>
		<th colspan="2" style="text-align:center;">东汽后三名</th></tr>
	<tr>
		<td><span id="effit-1"></span></td><td><span id="effi-1"></span></td>
		<td><span id="effit2-1"></span></td><td><span id="effi2-1"></span></td>
	</tr>
	<tr>
		<td><span id="effit-2"></span></td><td><span id="effi-2"></span></td>
		<td><span id="effit2-2"></span></td><td><span id="effi2-2"></span></td>
	</tr>
	<tr>
		<td><span id="effit-3"></span></td><td><span id="effi-3"></span></td>
		<td><span id="effit2-3"></span></td><td><span id="effi2-3"></span></td>
	</tr>
	</table>
</div>

<div style="position:absolute;right:320px;top:70px;width:280px;" class="panel panel-primary">
<div class="panel-heading"><script>document.write(OptNames[1][0][0]);</script></div>
	<table id="effi" class="suttable" style="margin:5px 2%;height:100px;width:96%;">
	<tr>
		<th colspan="2" style="text-align:center;">金风后三名</th>
		<th colspan="2" style="text-align:center;">东汽后三名</th></tr>
	<tr>
		<td><span id="pitcht-1"></span></td><td><span id="pitch-1"></span></td>
		<td><span id="pitcht2-1"></span></td><td><span id="pitch2-1"></span></td>
	</tr>
	<tr>
		<td><span id="pitcht-2"></span></td><td><span id="pitch-2"></span></td>
		<td><span id="pitcht2-2"></span></td><td><span id="pitch2-2"></span></td>
	</tr>
	<tr>
		<td><span id="pitcht-3"></span></td><td><span id="pitch-3"></span></td>
		<td><span id="pitcht2-3"></span></td><td><span id="pitch2-3"></span></td>
	</tr>
	</table>
</div>


<div style="position:absolute;top:70px;right:20px;width:280px;" class="panel panel-primary">
<div class="panel-heading"><script>document.write(OptNames[2][0][0]);</script></div>
	<table id="effi" class="suttable" style="margin:5px 2%;height:100px;width:96%;">
	<tr>
		<th colspan="2" style="text-align:center;">金风后三名</th>
		<th colspan="2" style="text-align:center;">东汽后三名</th></tr>
	<tr>
		<td><span id="windt-1"></span></td><td><span id="wind-1"></span></td>
		<td><span id="windt2-1"></span></td><td><span id="wind2-1"></span></td>
	</tr>
	<tr>
		<td><span id="windt-2"></span></td><td><span id="wind-2"></span></td>
		<td><span id="windt2-2"></span></td><td><span id="wind2-2"></span></td>
	</tr>
	<tr>
		<td><span id="windt-3"></span></td><td><span id="wind-3"></span></td>
		<td><span id="windt2-3"></span></td><td><span id="wind2-3"></span></td>
	</tr>
	</table>
</div>

<div style="position:absolute;top:230px;right:390px;width:210px;" class="panel panel-primary">
<div class="panel-heading"><script>document.write(OptNames[3][0][0]);</script></div>
	<table id="effi" class="suttable" style="margin:5px 2%;height:60px;width:96%;">
	<tr>
		<td>活动扇区</td><td><span id="sector-1"></span></td>
	<tr>
	</tr>
		<td>尾流影响机组</td><td><span id="sector-2"></span></td>
	</tr>
	</table>
</div>

<div style="position:absolute;top:230px;right:20px;width:350px;" class="panel panel-primary">
<div class="panel-heading"><script>document.write(OptNames[4][0][0]);</script></div>
	<table id="effi" class="suttable" style="margin:5px 2%;height:130px;width:96%;">
	<tr>
		<th colspan="2">风电场总无功需求值</th><th colspan="2"><span id="sector-1"></span></th>
	</tr>
	<tr>
		<th colspan="2">优化前</th><th colspan="2">优化后</th>
	</tr>
	<tr>
		<td>机组无功输出</td><td><span id="follow-1">1000kVar</span></td>
		<td>机组无功输出</td><td><span id="follow2-1">1000kVar</span></td>
	</tr>
	<tr>
		<td>风电场无功补偿</td><td><span id="follow-2"></span></td>
		<td>风电场无功补偿</td><td><span id="follow2-2"></span></td>
	</tr>
	<tr>
		<td>无功损耗</td><td><span id="follow-3"></span></td>
		<td>无功损耗</td><td><span id="follow2-3"></span></td>
	</tr>
	</table>
</div>

		<canvas id="canover"></canvas>
	</div>
<script>

var turbpic = "${assetPath(src: 'bladebig_blue.png')}";
var turbpicred = "${assetPath(src: 'bladelittle_red.png')}";

function UpdateOver() {
	UpdateOverFarm ();
	window.setTimeout ( UpdateOver, UPDATESPAN );
}

function resizeHome() {
	var height = $(window).height();		
	var width = $(window).width();		

	var cansector = document.getElementById ('canover');
	cansector.width = width;
	cansector.height = height - 100;
}
	
$(document).ready(function(){
	InitPos();
	resizeHome();
	UpdateOver();
});

$(window).resize(function(){
	resizeHome();
	UpdateOverFarm ();
});

</script>
    </body>
</html>

