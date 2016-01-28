<!doctype html>
<html>
    <head> <meta name="layout" content="main"/> </head>
    <body>
  	<asset:stylesheet src="bootstrap-datetimepicker.min.css"/>
	<asset:javascript src="bootstrap-datetimepicker.js"/>
	<asset:javascript src="bootstrap-datetimepicker.zh-CN.js"/>
	<asset:javascript src="curve.js"/>
	<asset:javascript src="power.js"/>

	<div class="mainpage">
	<div class="container">

<div class="panel panel-default">
  <div class="panel-heading">功率特性表现排名</div>
  <br/>

	<g:if test="${state==0}">
			<script>alert ( '数据库更新错误！所有数值只是页面展示作用！' );</script>
	</g:if>
  <table class="table">
	<tr><th width="10%">排名</th><th width="20%">机组号</th><th>与平均比较</th></tr>
	<g:each var="ef" status="index" in="${effi}">
	<g:if test="${ef.turbnum<=33}">
		<tr><td>${index+1}</td><td>金风第${ef.turbnum}号机组</td>
	</g:if>
	<g:if test="${ef.turbnum>33}">
		<tr><td>${index+1}</td><td>东汽第${ef.turbnum-33}号机组</td>
	</g:if>
	<g:if test="${ef.value>-123.0}">
		<td>
		<div class="progress">
		<g:if test="${ef.value>0}">
		<g:if test="${ef.value>1}">
			<div class="progress-bar progress-bar-success" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width:100%;"> ${((int)(ef.value*10000))/100.0}% </div>
		</g:if>
		<g:if test="${ef.value<=1}">
			<div class="progress-bar progress-bar-info" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width:${((int)(ef.value*10000)/100.0)}%;min-width:4em;"> ${((int)(ef.value*10000))/100.0}% </div>
		</g:if>
		</g:if>

		<g:if test="${ef.value<0}">
		<g:if test="${ef.value<-1}">
			<div class="progress-bar progress-bar-danger" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width:100%;"> ${((int)(ef.value*10000))/100.0}% </div>
		</g:if>
		<g:if test="${ef.value>=-1}">
			<div class="progress-bar progress-bar-warning" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width:${((int)(-ef.value*10000)/100.0)}%;min-width:4em;"> ${((int)(ef.value*10000))/100.0}% </div>
		</g:if>
		</g:if>
		</div>
		</td></tr>
	</g:if>
	<g:if test="${ef.value<-123.0}">
		<td>
		<div class="progress">
			<div class="progress-bar progress-bar-warning" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width:0%;"> --------- </div>
		</div>
		
		</td></tr>
	</g:if>
	</g:each>


  </table>
</div>
</div>
</div>

    </body>
</html>
