
<!doctype html>
<html>
    <head> 
		<meta name="layout" content="main"/> 
	</head>
    <body>

	<div class="mainpage">
	<div class="container">

	<div class="row">
	<div class="col-lg-6 col-md-12">
	<div id="power" class="panel">
	    <div class="panel-heading">
			<a href="${createLink([action:'index',controller:'power'])}">
 				<script>document.write(OptimizeType[3]);</script>
			</a>
		</div>

		<div class="content">
		<div class="row" style="height:100%;">
		<div class=" col-xs-12 col-sm-4 col-lg-4" style="height:100%;">
			<table id="effi" class="suttable" style="height:100%;width:100%;">
			<tr><td><img src="${assetPath(src: 'rank1.png')}"/></td><td></td><td><span id="forLost">233kVar</span></td></tr>
			<tr><td><img src="${assetPath(src: 'rank2.png')}"/></td><td>优化前损耗</td><td><span id="forLost">233kVar</span></td></tr>
			<tr><td><img src="${assetPath(src: 'rank3.png')}"/></td><td>优化前损耗</td><td><span id="forLost">233kVar</span></td></tr>
			<tr><td colspan="3">......</td></tr>
			<tr><td><img src="${assetPath(src: 'rank-3.png')}"/></td><td>优化前损耗</td><td><span id="forLost">233kVar</span></td></tr>
			<tr><td><img src="${assetPath(src: 'rank-2.png')}"/></td><td>优化前损耗</td><td><span id="forLost">233kVar</span></td></tr>
			<tr><td><img src="${assetPath(src: 'rank-1.png')}"/></td><td>优化前损耗</td><td><span id="forLost">233kVar</span></td></tr>
			</table>
		</div>
		<div class="col-xs-12 col-sm-8 col-lg-8" style="height:100%;">
			<div id="canpowerparent" style="height:100%;width:100%;"><canvas id="canpower" width="100%" height="100%"></canvas></div>
		</div>
		</div>
		</div>



	</div>
	</div>

	<div class="col-lg-6 col-md-12">
	<div id="pitch" class="panel">
	    <div class="panel-heading">
			<a href="${createLink([action:'index',controller:'pitch'])}">
 				<script>document.write(OptimizeType[5]);</script>
			</a>
			</div>
 		<script>//document.write(getPitchOverall());</script>
		<div class="content">
		</div>
	</div>
	</div>

	</div>

	<div class="row">
	<div class="col-lg-6 col-md-12">
	<div id="wind" class="panel">
	    <div class="panel-heading">
			<a href="${createLink([action:'index',controller:'wind'])}">
 				<script>document.write(OptimizeType[7]);</script>
			</a>
			</div>
 		<script>//document.write(getWindOverall());</script>
		<div class="content">
		</div>
	</div>
	</div>

	<div class="col-lg-6 col-md-12">
	<div id="sector" class="panel">
	    <div class="panel-heading">
			<a href="${createLink([action:'index',controller:'sector'])}">
 				<script>document.write(OptimizeType[9]);</script>
			</a>
			</div>
 		<script>//document.write(getSectorOverall());</script>
		<div class="content">
		</div>
	</div>
	</div>
	</div>

	<div class="row">
	<div class="col-lg-12 col-md-12">
	<div id="follow" class="panel">
	    <div class="panel-heading">
			<a href="${createLink([action:'index',controller:'follow'])}">
 				<script>document.write(OptimizeType[11]);</script>
			</a>
			</div>
		<div class="content">
		<div class="row" style="height:100%;">
		<div class=" col-xs-12 col-sm-3 col-lg-3" style="height:100%;">
			<table class="suttable" style="height:100%;width:100%;">
			<tr><td width="50%">优化前损耗</td><td><span id="forLost">233kVar</span></td></tr>
			<tr><td>优化后损耗</td><td><span id="aftLost">233kVar</span></td></tr>
			<tr><td>电容器无功</td><td><span id="capvar">233kVar</span></td></tr>
			<tr><td>节省电容器</td><td><span id="capsave">233kVar</span></td></tr>
			</table>
		</div>
		<div class="col-xs-12 col-sm-9 col-lg-9" style="height:100%;">
			<div id="canfollowparent" style="height:100%;width:100%;"><canvas id="canfollow" width="100%" height="100%"></canvas></div>
		</div>
		</div>
		</div>

	</div>
	</div>
	</div>

	</div>
	</div>

	<asset:javascript src="curve.js"/>
	<asset:javascript src="power.js"/>
	<asset:javascript src="follow.js"/>
	<script>

var urlpower = "${createLink(controller='power',action:'getupdatedata')}";
var urlfollow = "${createLink(controller='follow',action:'getupdatedata')}";

function UpdateOver() {
	UpdatePowerRank( urlpower, $('#canpowerparent'), 'canpower' );
	UpdateFollowRank( urlfollow, $('#canfollowparent'), 'canfollow' );
	window.setTimeout ( UpdateOver, UPDATESPAN );
}

//HighNav ( '主页' ); 

function Resize() {
	var height = $(window).height();		
	var width = $(window).width();		
	if ( height > 400 && width > 970 ) {
		var clientheight = height - 240;
		$('#power > .content').height( clientheight/3 );
		$('#pitch > .content').height( clientheight/3 );
		$('#wind > .content').height( clientheight/3 );
		$('#sector > .content').height( clientheight/3 );
		$('#follow > .content').height( clientheight/3 );
	}
}

$(document).ready(function(){
	Resize();
	UpdateOver();
});

$(window).resize(function(){
	Resize();
});

	</script>

    </body>
</html>
