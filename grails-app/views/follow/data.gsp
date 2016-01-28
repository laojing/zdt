<!doctype html>
<html>
    <head> <meta name="layout" content="main"/> </head>
    <body>
	<div class="mainpage">
	<div class="container">

<div class="panel panel-default">
  <div class="panel-heading">主变压器有功损耗</div>
  <br/>
  <table class="table">
	<g:each var="ef" status="index" in="${effi}">
	<g:if test="${ef.turbnum==200}">
		<tr><th>优化前有功损耗</th><th>${ef.value}kW</th></tr>
	</g:if>
	<g:if test="${ef.turbnum==300}">
		<tr><th>优化后有功损耗</th><th>${ef.value}kW</th></tr>
	</g:if>
	</g:each>
  </table>
</div>


<div class="panel panel-default">
  <div class="panel-heading">35kV母线有功损耗</div>
  <br/>
  <table class="table">
	<tr><th width="10%">线路号</th><th width="20%">优化前有功损耗</th><th>优化后有功损耗</th></tr>
	<g:each var="ef" status="index" in="${effi}">
	<g:if test="${ef.turbnum>200 && ef.turbnum<206}">
		<tr><td>${ef.turbnum-200}</td><td>${ef.var}kW</td><td>${ef.power}kW</td></tr>
	</g:if>
	</g:each>
  </table>
</div>


<div class="panel panel-default">
  <div class="panel-heading">机组无功分配结果</div>
  <br/>
  <table class="table">
	<tr><th width="10%">机组号</th><th width="20%">有功</th><th>无功分配</th></tr>
	<g:each var="ef" status="index" in="${effi}">
	<g:if test="${ef.turbnum<=66}">
		<tr><td>${ef.turbnum}</td><td>${ef.power}kW</td><td>${ef.value}kVar</td></tr>
	</g:if>
	</g:each>
  </table>
</div>


</div>
</div>


<script>

function resize() {
	var height = $(window).height();		
	var width = $(window).width();		

}
var urlpower = "${createLink(controller='follow',action:'getupdatedata')}";
function UpdateOver() {


	window.setTimeout ( UpdateOver, UPDATESPAN );
}

$(document).ready(function(){
	resize();
	UpdateOver();
});

$(window).resize(function(){
	resize();
});

</script>

    </body>
</html>
