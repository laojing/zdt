<!doctype html>
<html>
    <head> <meta name="layout" content="main"/> </head>

    <body>
	<asset:javascript src="turbpos.js"/>
	<asset:javascript src="wind.js"/>

<div style="position:absolute;right:300px;top:80px;">
<label class="checkbox-inline">
  <input onchange="DispChange();" type="checkbox" id="distype1" value="option1" checked> 显示金风机组
</label>
<label class="checkbox-inline">
  <input onchange="DispChange();" type="checkbox" id="distype2" value="option2" checked> 显示东汽机组
</label>
</div>

	<div class="mainpage">
		<canvas id="windpic"></canvas>
	</div>
<script>


var windurl = "${createLink(controller='wind',action:'getcurdata')}";
var turbpic = "${assetPath(src: 'bladebig_blue.png')}";
var turbpicred = "${assetPath(src: 'bladelittle_red.png')}";

var disptype1 = true;
var disptype2 = true;
function DispChange () {
	if ( document.getElementById('distype1').checked ) disptype1 = true;
	else disptype1 = false;
	if ( document.getElementById('distype2').checked ) disptype2 = true;
	else disptype2 = false;
	UpdateWindPic( false );
}
function UpdatePitch() {
	UpdateWindPic( false );
	window.setTimeout ( UpdatePitch, UPDATESPAN );
}

//HighNav ( '风速风向' ); 

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
	UpdatePitch();
});

$(window).resize(function(){
	resizeHome();
	UpdateWindPic( false );
});

</script>

    </body>
</html>
