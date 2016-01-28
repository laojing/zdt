<!doctype html>
<html>
    <head> <meta name="layout" content="main"/> </head>

    <body>
	<asset:javascript src="turbpos.js"/>
	<asset:javascript src="wind.js"/>
	<div class="mainpage">
		<canvas id="windpic"></canvas>
	</div>
<script>

var sectorurl = "${createLink(controller='sector',action:'getcurdata')}";
var turbpic = "${assetPath(src: 'bladelittle_blue.png')}";
var turbpicred = "${assetPath(src: 'bladelittle_red.png')}";

function UpdateOver() {
	UpdateSectorPic( false );
	window.setTimeout ( UpdateOver, UPDATESPAN );
}

function resizeHome() {
	var height = $(window).height();		
	var width = $(window).width();		

	var cansector = document.getElementById ('windpic');
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
	UpdateSectorPic( false );
});


</script>

    </body>
</html>
